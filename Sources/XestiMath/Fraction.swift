// © 2025 John Gary Pusey (see LICENSE.md)

internal struct Fraction {

    // MARK: Private Initializers

    private init(_ nvalue: ExactInteger,
                 _ dvalue: ExactInteger) {
        self.dvalue = dvalue
        self.nvalue = nvalue
    }

    // MARK: Private Instance Properties

    private let dvalue: ExactInteger
    private let nvalue: ExactInteger
}

// MARK: -

extension Fraction {

    // MARK: Internal Type Methods

    internal static func parse(_ text: String,
                               radix: Number.Radix) -> Self? {
        let lcText = text.lowercased()

        if let (ntval, dtval) = _matchFraction(lcText,
                                               radix: radix),
           let nval = ExactInteger.parse(ntval,
                                         radix: radix),
           let dval = ExactInteger.parse(dtval,
                                         radix: radix) {
            return Self(numerator: nval,
                        denominator: dval)
        }

        return nil
    }

    // MARK: Internal Initializers

    internal init(numerator: ExactInteger,
                  denominator: ExactInteger,
                  reduce: Bool = true) {
        var num = numerator
        var den = denominator

        guard !den.isZero
        else { fatalError("Denominator must not be zero!") }

        if den.isNegative {
            num = num.negated()
            den = den.negated()
        }

        if reduce,
           !den.isEqual(to: .one) {
            if !num.isZero {
                let tmp = num.greatestCommonDivisor(with: den)

                if !tmp.isEqual(to: .one) {
                    num = num.quotient(dividingBy: tmp)
                    den = den.quotient(dividingBy: tmp)
                }
            } else {
                den = .one
            }
        }

        self.init(num, den)
    }

    // MARK: Internal Instance Properties

    internal var debugDescription: String {
        "fraction<\(nvalue.debugDescription), \(dvalue.debugDescription)>"
    }

    internal var denominator: ExactInteger {
        dvalue
    }

    internal var description: String {
        "\(nvalue.description)/\(dvalue.description)"
    }

    internal var exactIntegerValue: ExactInteger {
        nvalue.quotient(dividingBy: dvalue)
    }

    internal var floatingPointValue: FloatingPoint {
        nvalue.floatingPointValue.divided(by: dvalue.floatingPointValue)
    }

    internal var isInteger: Bool {
        dvalue.isEqual(to: .one)
    }

    internal var isNegative: Bool {
        nvalue.isNegative
    }

    internal var isPositive: Bool {
        nvalue.isPositive
    }

    internal var isZero: Bool {
        nvalue.isZero
    }

    internal var numerator: ExactInteger {
        nvalue
    }

    // MARK: Internal Instance Methods

    internal func adding(_ other: Self) -> Self {
        Self(numerator: nvalue.multiplied(by: other.dvalue).adding(dvalue.multiplied(by: other.nvalue)),
             denominator: dvalue.multiplied(by: other.dvalue))
    }

    internal func ceiling() -> ExactInteger {
        let result = exactIntegerValue

        if nvalue.isNegative || nvalue.isMultiple(of: dvalue) {
            return result
        }

        return result.adding(.one)
    }

    internal func divided(by other: Self) -> Self {
        Self(numerator: nvalue.multiplied(by: other.dvalue),
             denominator: dvalue.multiplied(by: other.nvalue))
    }

    internal func floor() -> ExactInteger {
        let result = exactIntegerValue

        if nvalue.isPositive || nvalue.isMultiple(of: dvalue) {
            return result
        }

        return result.subtracting(.one)
    }

    internal func isEqual(to other: Self) -> Bool {
        nvalue.isEqual(to: other.nvalue) && dvalue.isEqual(to: other.dvalue)
    }

    internal func isLess(than other: Self) -> Bool {
        nvalue.multiplied(by: other.dvalue).isLess(than: dvalue.multiplied(by: other.nvalue))
    }

    internal func multiplied(by other: Self) -> Self {
        Self(numerator: nvalue.multiplied(by: other.nvalue),
             denominator: dvalue.multiplied(by: other.dvalue))
    }

    internal func negated() -> Self {
        Self(numerator: nvalue.negated(),
             denominator: dvalue,
             reduce: false)
    }

    internal func round() -> ExactInteger {
        let half = dvalue.bitwiseShiftRight(bits: 1)    // == denominator / 2

        var result = exactIntegerValue

        if nvalue.isNegative {
            let tmp = result.multiplied(by: dvalue).subtracting(nvalue)
            let more = (dvalue.isEven && tmp.isEqual(to: half)
                        ? result.isOdd
                        : half.isLess(than: tmp))

            if more {
                result = result.subtracting(.one)
            }
        } else {
            let tmp = nvalue.subtracting(result.multiplied(by: dvalue))
            let more = (dvalue.isEven && tmp.isEqual(to: half)
                        ? result.isOdd
                        : half.isLess(than: tmp))

            if more {
                result = result.adding(.one)
            }
        }

        return result
    }

    internal func subtracting(_ other: Self) -> Self {
        Self(numerator: nvalue.multiplied(by: other.dvalue).subtracting(dvalue.multiplied(by: other.nvalue)),
             denominator: dvalue.multiplied(by: other.dvalue))
    }

    internal func truncate() -> ExactInteger {
        exactIntegerValue
    }

    // MARK: Private Type Methods

    private static func _matchFraction(_ text: String,
                                       radix: Number.Radix) -> (String, String)? {
        let match = switch radix {
        case .binary:
            text.wholeMatch(of: Number.fracBinValue)

        case .decimal:
            text.wholeMatch(of: Number.fracDecValue)

        case .hexadecimal:
            text.wholeMatch(of: Number.fracHexValue)

        case .octal:
            text.wholeMatch(of: Number.fracOctValue)
        }

        guard let noutput = match?.1,
              let doutput = match?.2
        else { return nil }

        return (String(noutput), String(doutput))
    }
}
