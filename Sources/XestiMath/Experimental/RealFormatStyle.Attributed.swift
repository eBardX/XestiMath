//// © 2025 John Gary Pusey (see LICENSE.md)
//
// import BigInt
// import Foundation
//
// extension RealFormatStyle {
//    public struct Attributed {
//
//        // MARK: Public Initializers
//
//        public init(baseStyle: RealFormatStyle) {
//            self.baseStyle = baseStyle
//        }
//
//        // MARK: Private Instance Properties
//
//        private let baseStyle: RealFormatStyle
//    }
// }
//
//// MARK: - FormatStyle
//
// extension RealFormatStyle.Attributed: FormatStyle {
//    public func format(_ value: Number) -> AttributedString {
//        switch value.value {
//        case let .exactInteger(exactIntegerValue):
//            _attributedFormatExactInteger(exactIntegerValue)
//
//        case let .floatingPoint(doubleValue):
//            _attributedFormatDouble(doubleValue)
//
//        case let .fraction(fractionValue):
//            _attributedFormatFraction(fractionValue)
//        }
//    }
//
//    // MARK: Private Instance Methods
//
//    private func _attributedFormatBigInt(_ value: BigInt) -> AttributedString {
//        let magStr = String(value.magnitude)
//
//        var result = AttributedString(value < 0 ? "-" : "")
//
//        if magStr.count > 3 {
//            let grpSep = AttributedString(baseStyle.locale.groupingSeparator ?? ",",
//                                          attributes: AttributeContainer.realSymbol(.groupingSeparator))
//
//            var group = (3 - (magStr.count % 3)) % 3
//
//            for char in magStr {
//                if group == 3 {
//                    result += grpSep
//
//                    group = 0
//                }
//
//                result += AttributedString(String(char))
//
//                group += 1
//            }
//        } else {
//            result += AttributedString(magStr)
//        }
//
//        result.realPart = .integer
//
//        return result
//    }
//
//    private func _attributedFormatDenominator(_ value: ExactInteger) -> AttributedString {
//        var result = _attributedFormatExactInteger(value)
//
//        result.replaceAttributes(AttributeContainer.realPart(.integer),
//                                 with: AttributeContainer.realPart(.denominator))
//
//        return result
//    }
//
//    private func _attributedFormatDouble(_ value: Double) -> AttributedString {
//        var result = baseStyle.doubleFormatStyle.attributed.format(value)
//
//        result.replaceFoundationAttributes()
//
//        return result
//    }
//
//    private func _attributedFormatExactInteger(_ value: ExactInteger) -> AttributedString {
//        switch value.value {
//        case let .large(bigIntValue):
//            _attributedFormatBigInt(bigIntValue)
//
//        case let .small(intValue):
//            _attributedFormatInt(intValue)
//        }
//    }
//
//    private func _attributedFormatFraction(_ value: Fraction) -> AttributedString {
//        let isFrac = value.denominator != 1
//
//        if isFrac && baseStyle.displaysFractionAsDecimal {
//            return _attributedFormatDouble(value.doubleValue)
//        }
//
//        if isFrac || baseStyle.alwaysDisplaysDenominator {
//            var result = _attributedFormatNumerator(value.numerator)
//
//            result += AttributedString("/",
//                                       attributes: AttributeContainer.realSymbol(.fractionBar))
//
//            result += _attributedFormatDenominator(value.denominator)
//
//            return result
//        }
//
//        return _attributedFormatExactInteger(value.numerator)
//    }
//
//    private func _attributedFormatInt(_ value: Int) -> AttributedString {
//        var result = baseStyle.intFormatStyle.attributed.format(value)
//
//        result.replaceFoundationAttributes()
//
//        return result
//    }
//
//    private func _attributedFormatNumerator(_ value: ExactInteger) -> AttributedString {
//        var result = _attributedFormatExactInteger(value)
//
//        result.replaceAttributes(AttributeContainer.realPart(.integer),
//                                 with: AttributeContainer.realPart(.numerator))
//
//        return result
//    }
// }
