// © 2025 John Gary Pusey (see LICENSE.md)

extension Real {

    // MARK: Public Type Methods

    public static func parse<S: StringProtocol>(_ value: S,
                                                schemeSyntax: Bool = false) -> Self? {
        if schemeSyntax {
            guard let (text, radix, exact) = String(value).parseSchemePrefixes()
            else { return nil }

            return parse(text,
                         radix: radix,
                         exact: exact)
        } else {
            return parse(value,
                         radix: 10)
        }
    }

    // MARK: Internal Type Methods

    internal static func parse<S: StringProtocol>(_ value: S,
                                                  radix: Int,
                                                  exact: Bool? = nil) -> Self? {
        switch exact {
        case true:
            if let tmpValue = ExactInteger.parse(value,
                                                 radix: radix) {
                Self(exactInteger: tmpValue)
            } else if let tmpValue = Fraction.parse(value,
                                                    radix: radix) {
                Self(fraction: tmpValue)
            } else {
                nil
            }

        case false:
            if let tmpValue = ExactInteger.parse(value,
                                                 radix: radix) {
                Self(floatingPoint: tmpValue.doubleValue)
            } else if let tmpValue = Fraction.parse(value,
                                                    radix: radix) {
                Self(floatingPoint: tmpValue.doubleValue)
            } else if radix == 10,
                      let tmpValue = Double(value) {
                Self(floatingPoint: tmpValue)
            } else {
                nil
            }

        case nil:
            if let tmpValue = ExactInteger.parse(value,
                                                 radix: radix) {
                Self(exactInteger: tmpValue)
            } else if let tmpValue = Fraction.parse(value,
                                                    radix: radix) {
                Self(fraction: tmpValue)
            } else if radix == 10,
                      let tmpValue = Double(value) {
                Self(floatingPoint: tmpValue)
            } else {
                nil
            }

        default:
            nil
        }
    }
}
