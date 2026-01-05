// © 2025 John Gary Pusey (see LICENSE.md)

import BigInt
import Foundation

extension Number.FormatStyle {

    // MARK: Public Nested Types

    public struct Attributed {

        // MARK: Public Initializers

        public init(baseStyle: Number.FormatStyle) {
            self.baseStyle = baseStyle
        }

        // MARK: Private Instance Properties

        private let baseStyle: Number.FormatStyle
    }
}

// MARK: - FormatStyle

extension Number.FormatStyle.Attributed: FormatStyle {

    // MARK: Public Instance Methods

    public func format(_ value: Number) -> AttributedString {
        switch value.value {
        case let .complex(cxValue):
            _attributedFormatComplex(cxValue)

        case let .real(reValue):
            _attributedFormatReal(reValue)
        }
    }

    // MARK: Private Nested Types

    private typealias XNumberPart = AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberPartAttribute.XNumberPart

    // MARK: Private Instance Methods

    private func _attributedFormatComplex(_ value: Complex) -> AttributedString {
        var result = _attributedFormatReal(value.realPart, .realPart)

        let ivalue = value.imaginaryPart

        if !ivalue.isNegative {
            result += AttributedString("+",
                                       attributes: AttributeContainer.xnumberSymbol(.sign))
        }

        result += _attributedFormatReal(ivalue, .imaginaryPart)

        result += AttributedString("i",
                                   attributes: AttributeContainer.xnumberSymbol(.imaginaryUnit))

        return result
    }

    private func _attributedFormatExactInteger(_ value: ExactInteger,
                                               _ overallPart: XNumberPart? = nil) -> AttributedString {
        switch value.value {
        case let .large(lgValue):
            _attributedFormatLarge(lgValue, overallPart)

        case let .small(smValue):
            _attributedFormatSmall(smValue, overallPart)
        }
    }

    private func _attributedFormatFloatingPoint(_ value: FloatingPoint,
                                                _ overallPart: XNumberPart? = nil) -> AttributedString {
        var result = baseStyle.doubleFormatStyle.attributed.format(value.doubleValue)

        result.replaceFoundationAttributes()

        if let overallPart {
            if value.isNegative {
                let idx = result.index(afterCharacter: result.startIndex)

                result[idx...].xnumberPart = overallPart
            } else {
                result.xnumberPart = overallPart
            }
        }

        return result
    }

    private func _attributedFormatFraction(_ value: Fraction,
                                           _ overallPart: XNumberPart? = nil) -> AttributedString {
        let isFrac = !value.denominator.isEqual(to: .one)

        if isFrac && baseStyle.displaysFractionAsDecimal {
            return _attributedFormatFloatingPoint(value.floatingPointValue)
        }

        if isFrac || baseStyle.alwaysDisplaysDenominator {
            var result = _attributedFormatExactInteger(value.numerator, .numerator)

            result += AttributedString("/",
                                       attributes: AttributeContainer.xnumberSymbol(.fractionBar))

            result += _attributedFormatExactInteger(value.denominator, .denominator)

            return result
        }

        return _attributedFormatExactInteger(value.numerator)
    }

    private func _attributedFormatLarge(_ value: BigInt,
                                        _ overallPart: XNumberPart? = nil) -> AttributedString {
        let magStr = String(value.magnitude)

        var result = AttributedString()

        if magStr.count > 3 {
            let grpSep = AttributedString(baseStyle.locale.groupingSeparator ?? ",",
                                          attributes: AttributeContainer.xnumberSymbol(.groupingSeparator))

            var group = (3 - (magStr.count % 3)) % 3

            for char in magStr {
                if group == 3 {
                    result += grpSep

                    group = 0
                }

                result += AttributedString(String(char))

                group += 1
            }
        } else {
            result += AttributedString(magStr)
        }

        if let overallPart {
            result.xnumberPart = overallPart
        }

        if value < 0 {
            result = AttributedString("-",
                                      attributes: AttributeContainer.xnumberSymbol(.sign)) + result
        }

        return result
    }

    private func _attributedFormatReal(_ value: Real,
                                       _ overallPart: XNumberPart? = nil) -> AttributedString {
        switch value.value {
        case let .exactInteger(eiValue):
            _attributedFormatExactInteger(eiValue, overallPart)

        case let .floatingPoint(fpValue):
            _attributedFormatFloatingPoint(fpValue, overallPart)

        case let .fraction(frValue):
            _attributedFormatFraction(frValue, overallPart)
        }
    }

    private func _attributedFormatSmall(_ value: Int,
                                        _ overallPart: XNumberPart? = nil) -> AttributedString {
        var result = baseStyle.intFormatStyle.attributed.format(value)

        if let overallPart {
            result.replaceAttributes(AttributeContainer.numberPart(.integer),
                                     with: AttributeContainer.xnumberPart(overallPart))
        } else {
            result.numberPart = nil
        }

        result.replaceFoundationAttributes()

        return result
    }
}
