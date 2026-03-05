// © 2025—2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Type Methods

    public static func parse<S: StringProtocol>(input: S) -> Self? {
        guard let (text, radix, exactness) = _matchPrefixes(input: String(input))
        else { return nil }

        return parse(input: text,
                     radix: radix,
                     exactness: exactness)
    }

    // MARK: Internal Type Methods

    internal static func parse<S: StringProtocol>(input: S,
                                                  radix: Radix,
                                                  exactness: Exactness) -> Self? {
        guard let value = _parseNumber(input: String(input),
                                       radix: radix,
                                       exactness: exactness)
        else { return nil }

        return value
    }

    // MARK: Private Type Properties

    private static let exactnesses: [String: Exactness] = ["#e": .exact,
                                                           "#i": .inexact]

    private static let radixes: [String: Radix] = ["#b": .binary,
                                                   "#d": .decimal,
                                                   "#h": .hexadecimal,
                                                   "#o": .octal]

    // MARK: Private Type Methods

    private static func _matchPrefixes(input: String) -> (String, Radix, Exactness)? {
        var exactness: Exactness?
        var radix: Radix?
        var text = input

        while !text.isEmpty, radix == nil || exactness == nil {
            if let prefix = text.prefixMatch(of: Self.pfxRadix)?.output,
               let tmpRadix = Self.radixes[String(prefix)] {
                guard radix == nil      // should be (at most) a single radix prefix
                else { return nil }

                radix = tmpRadix
                text = String(text.dropFirst(2))

                continue    // check for another prefix
            }

            if let prefix = text.prefixMatch(of: Self.pfxExactness)?.output,
               let tmpExactness = Self.exactnesses[String(prefix)] {
                guard exactness == nil  // should be (at most) a single exactness prefix
                else { return nil }

                exactness = tmpExactness
                text = String(text.dropFirst(2))

                continue    // check for another prefix
            }

            break   // no more prefixes
        }

        return (text, radix ?? .decimal, exactness ?? .unspecified)
    }

    private static func _parseNumber(input: String,
                                     radix: Radix,
                                     exactness: Exactness) -> Self? {
        if let rval = Complex.parse(input: input,
                                    radix: radix,
                                    exactness: exactness) {
            return Self(.complex(rval))
        }

        if let rval = Real.parse(input: input,
                                 radix: radix,
                                 exactness: exactness) {
            return Self(.real(rval))
        }

        return nil
    }
}
