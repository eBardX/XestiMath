// © 2025 John Gary Pusey (see LICENSE.md)

import BigInt

extension ExactInteger {

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
        guard let biValue = BigInt(value,
                                   radix: radix)
        else { return nil }

        return .init(biValue)
    }
}
