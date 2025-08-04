// © 2025 John Gary Pusey (see LICENSE.md)

extension Fraction {

    // MARK: Internal Instance Methods

    internal func ceiling() -> ExactInteger {
        if numerator < 0 {
            quotient(numerator, denominator)
        } else if !numerator.isMultiple(of: denominator) {
            quotient(numerator, denominator) + 1
        } else {
            quotient(numerator, denominator)
        }
    }

    internal func floor() -> ExactInteger {
        if numerator > 0 || numerator.isMultiple(of: denominator) { // >= 0 ???
            quotient(numerator, denominator)
        } else {
            quotient(numerator, denominator) - 1
        }
    }

    internal func round() -> ExactInteger {
        var quo = numerator / denominator

        let half = denominator / 2

        if numerator < 0 {
            let delta = (quo * denominator) - numerator
            let more = (denominator.isEven && delta == half
                        ? quo.isOdd
                        : delta > half)

            if more {
                quo = quo - 1   // swiftlint:disable:this shorthand_operator
            }
        } else {
            let delta = numerator - (quo * denominator)
            let more = (denominator.isEven && delta == half
                        ? quo.isOdd
                        : delta > half)

            if more {
                quo = quo + 1   // swiftlint:disable:this shorthand_operator
            }
        }

        return quo
    }

    internal func truncate() -> ExactInteger {
        quotient(numerator, denominator)
    }
}
