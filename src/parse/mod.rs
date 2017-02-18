mod encoding;
mod multi;

use encoding::Primitive;

pub use self::encoding::{StrEncoding, ParseEncodingError};

const QUALIFIERS: &'static [char] = &[
    'r', // const
    'n', // in
    'N', // inout
    'o', // out
    'O', // bycopy
    'R', // byref
    'V', // oneway
];

fn chomp(s: &str) -> (Option<&str>, &str) {
    let head_len = chomp_ptr(s)
        .or_else(|| chomp_nested_delims(s, '[', ']'))
        .or_else(|| chomp_nested_delims(s, '{', '}'))
        .or_else(|| chomp_nested_delims(s, '(', ')'))
        .or_else(|| {
            if let (Some(_), t) = chomp_primitive(s) {
                Some(s.len() - t.len())
            } else {
                None
            }
        });

    if let Some(head_len) = head_len {
        let (h, t) = s.split_at(head_len);
        (Some(h), t)
    } else {
        (None, s)
    }
}

fn chomp_ptr(s: &str) -> Option<usize> {
    if s.starts_with("^") {
        let (h, _) = chomp(&s[1..]);
        h.map(|h| h.len() + 1)
    } else {
        None
    }
}

fn chomp_nested_delims(s: &str, open: char, close: char) -> Option<usize> {
    if !s.starts_with(open) {
        return None;
    }

    let mut depth = 0;
    let close_index = s.find(|c: char| {
        if c == open {
            depth += 1;
        } else if c == close {
            depth -= 1;
        }
        // when the depth hits 0, we've found the close delim
        depth == 0
    });
    // the total length is 1 more than the index of the close delim
    close_index.map(|i| i + 1)
}

fn chomp_primitive(s: &str) -> (Option<Primitive>, &str) {
    if s.is_empty() {
        return (None, s);
    }

    let (h, t) = s.split_at(1);
    let primitive = match h {
        "c" => Primitive::Char,
        "s" => Primitive::Short,
        "i" => Primitive::Int,
        "l" => Primitive::Long,
        "q" => Primitive::LongLong,
        "C" => Primitive::UChar,
        "S" => Primitive::UShort,
        "I" => Primitive::UInt,
        "L" => Primitive::ULong,
        "Q" => Primitive::ULongLong,
        "f" => Primitive::Float,
        "d" => Primitive::Double,
        "B" => Primitive::Bool,
        "v" => Primitive::Void,
        "*" => Primitive::String,
        "@" => {
            // Special handling for blocks
            if t.starts_with('?') {
                return (Some(Primitive::Block), &t[1..]);
            }
            Primitive::Object
        }
        "#" => Primitive::Class,
        ":" => Primitive::Sel,
        "?" => Primitive::Unknown,
        "b" => {
            // Chomp until we hit a non-digit
            let (num, t) = match t.find(|c: char| !c.is_digit(10)) {
                Some(i) => t.split_at(i),
                None => (t, ""),
            };
            return match num.parse() {
                Ok(b) => (Some(Primitive::BitField(b)), t),
                Err(_) => (None, s),
            };
        }
        _ => return (None, s),
    };
    (Some(primitive), t)
}

#[derive(Debug, PartialEq, Eq)]
enum ParseResult<'a> {
    Primitive(Primitive),
    Pointer(&'a str),
    Array(u32, &'a str),
    Struct(&'a str, &'a str),
    Union(&'a str, &'a str),
    Error,
}

fn parse_parts(s: &str, open: char, sep: char, close: char)
        -> Option<(&str, &str)> {
    if s.starts_with(open) && s.ends_with(close) {
        s.find(sep).map(|i| (&s[1..i], &s[i + 1..s.len() - 1]))
    } else {
        None
    }
}

fn parse(s: &str) -> ParseResult {
    // strip qualifiers
    let s = s.trim_left_matches(QUALIFIERS);

    if s.starts_with('^') {
        ParseResult::Pointer(&s[1..])
    } else if s.starts_with('[') {
        parse_parts(s, '[', '^', ']')
            .and_then(|(len, item)| len.parse().map(|len| (len, item)).ok())
            .map(|(len, item)| ParseResult::Array(len, item))
            .unwrap_or(ParseResult::Error)
    } else if s.starts_with('{') {
        parse_parts(s, '{', '=', '}')
            .map(|(name, fields)| ParseResult::Struct(name, fields))
            .unwrap_or(ParseResult::Error)
    } else if s.starts_with('(') {
        parse_parts(s, '(', '=', ')')
            .map(|(name, members)| ParseResult::Union(name, members))
            .unwrap_or(ParseResult::Error)
    } else {
        match chomp_primitive(s) {
            (Some(p), t) if t.is_empty() => ParseResult::Primitive(p),
            _ => ParseResult::Error,
        }
    }
}

fn is_valid(s: &str) -> bool {
    match parse(s) {
        ParseResult::Primitive(_) => true,
        ParseResult::Pointer(s) |
        ParseResult::Array(_, s) => {
            is_valid(s)
        }
        ParseResult::Struct(_, mut members) |
        ParseResult::Union(_, mut members) => {
            while !members.is_empty() {
                let (h, t) = chomp(members);
                if !h.map_or(false, is_valid) {
                    return false;
                }
                members = t;
            }
            true
        }
        ParseResult::Error => false,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_chomp() {
        let (h, t) = chomp("{A={B=ci^{C=c}}ci}c^i{C=c}");
        assert_eq!(h, Some("{A={B=ci^{C=c}}ci}"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("c"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("^i"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("{C=c}"));

        let (h, _) = chomp(t);
        assert_eq!(h, None);
    }

    #[test]
    fn test_chomp_delims() {
        let (h, t) = chomp("{A=(B=ci)ci}[12{C=c}]c(D=ci)i");
        assert_eq!(h, Some("{A=(B=ci)ci}"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("[12{C=c}]"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("c"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("(D=ci)"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("i"));

        let (h, _) = chomp(t);
        assert_eq!(h, None);
    }

    #[test]
    fn test_chomp_bad_delims() {
        let (h, _) = chomp("{A={B=ci}ci");
        assert_eq!(h, None);

        let (h, _) = chomp("}A=ci{ci");
        assert_eq!(h, None);

        let (h, t) = chomp("{A=(B=ci}[12{C=c})]");
        assert_eq!(h, Some("{A=(B=ci}"));

        let (h, t) = chomp(t);
        assert_eq!(h, Some("[12{C=c})]"));

        let (h, _) = chomp(t);
        assert_eq!(h, None);
    }

    #[test]
    fn test_parse_block() {
        assert_eq!(parse("@?"), ParseResult::Primitive(Primitive::Block));
        assert_eq!(parse("@??"), ParseResult::Error);
        assert_eq!(chomp_primitive("@?c"), (Some(Primitive::Block), "c"));
        assert_eq!(chomp_primitive("@c?"), (Some(Primitive::Object), "c?"));
    }

    #[test]
    fn test_parse_bitfield() {
        assert_eq!(parse("b32"), ParseResult::Primitive(Primitive::BitField(32)));
        assert_eq!(parse("b-32"), ParseResult::Error);
        assert_eq!(parse("b32f"), ParseResult::Error);
        assert_eq!(chomp_primitive("b32b32"), (Some(Primitive::BitField(32)), "b32"));
        assert_eq!(chomp_primitive("bb32"), (None, "bb32"));
    }

    #[test]
    fn test_validation() {
        assert!(is_valid("c"));
        assert!(is_valid("{A={B=ci^{C=c}}ci}"));
        assert!(!is_valid("z"));
        assert!(!is_valid("{A=[12{C=c}}]"));
    }

    #[test]
    fn test_qualifiers() {
        assert_eq!(parse("Vv"), ParseResult::Primitive(Primitive::Void));
        assert_eq!(parse("r*"), ParseResult::Primitive(Primitive::String));
    }
}
