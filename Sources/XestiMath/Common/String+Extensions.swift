// © 2025 John Gary Pusey (see LICENSE.md)

extension String {

    // MARK: Internal Instance Methods

    internal func parseSchemePrefixes() -> (String, Int, Bool?)? {
        var value = String(self)
        var exact: Bool?
        var radix: Int?

        while value.hasPrefix("#") {
            guard let letter = value.dropFirst().first
            else { return nil }

            let (tmpRadix, tmpExact) = Self._convertSchemePrefix(letter)

            guard tmpExact != nil || tmpRadix != nil
            else { return nil }

            if let tmpExact,
               exact == nil {
                exact = tmpExact
            }

            if let tmpRadix,
               radix == nil {
                radix = tmpRadix
            }

            value = String(value.dropFirst(2))
        }

        return (value, radix ?? 10, exact)
    }

    // MARK: Private Type Methods

    private static func _convertSchemePrefix(_ letter: Character) -> (Int?, Bool?) {
        switch letter {
        case "b":
            return (2, nil)

        case "d":
            return (10, nil)

        case "e":
            return (nil, true)

        case "i":
            return (nil, false)

        case "o":
            return (8, nil)

        case "x":
            return (16, nil)

        default:
            return (nil, nil)
        }
    }
}
