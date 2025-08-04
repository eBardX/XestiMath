// © 2025 John Gary Pusey (see LICENSE.md)

extension Fraction {

    // MARK: Public Type Methods

    public static func parse<S: StringProtocol>(_ value: S,
                                                schemeSyntax: Bool = false) -> Self? {
        if schemeSyntax {
            guard let (text, radix, exact) = String(value).parseSchemePrefixes(),
                  exact == true
            else { return nil }

            return parse(text,
                         radix: radix)
        } else {
            return parse(value,
                         radix: 10)
        }
    }

    // MARK: Internal Type Methods

    internal static func parse<S: StringProtocol>(_ value: S,
                                                  radix: Int) -> Self? {
        let pair = value.split(separator: "/",
                               maxSplits: 1,
                               omittingEmptySubsequences: false)

        if pair.count == 2 {
            guard let num = ExactInteger.parse(pair[0],
                                               radix: radix),
                  let den = ExactInteger.parse(pair[1],
                                               radix: radix),
                  den > 0
            else { return nil }

            return .init(num, den, true)
        }

        guard let num = ExactInteger.parse(value,
                                           radix: radix)
        else { return nil }

        return .init(num, 1, false)
    }
}
