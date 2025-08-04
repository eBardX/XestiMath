//// © 2025 John Gary Pusey (see LICENSE.md)
//
// import BigInt
// import Foundation
//
// public struct RealFormatStyle {
//
//    // MARK: Public Initializers
//
//    public init(locale: Locale = .autoupdatingCurrent,
//                minimumDecimalDigits: Int = 6,
//                maximumDecimalDigits: Int = 6,
//                alwaysDisplaysDenominator: Bool = false,
//                displaysFractionAsDecimal: Bool = false) {
//        let minDigits = clamp(0, minimumDecimalDigits, 10)
//        let maxDigits = clamp(minDigits, maximumDecimalDigits, 10)
//
//        self.alwaysDisplaysDenominator = alwaysDisplaysDenominator
//        self.displaysFractionAsDecimal = displaysFractionAsDecimal
//        self.doubleFormatStyle = .init(locale: locale)
//            .decimalSeparator(strategy: .automatic)
//            .grouping(.automatic)
//            .precision(.fractionLength(minDigits...maxDigits))
//        self.intFormatStyle = .init(locale: locale)
//            .decimalSeparator(strategy: .automatic)
//            .grouping(.automatic)
//        self.locale = locale
//        self.maximumDecimalDigits = maxDigits
//        self.minimumDecimalDigits = minDigits
//    }
//
//    // MARK: Public Instance Properties
//
//    public let alwaysDisplaysDenominator: Bool
//    public let displaysFractionAsDecimal: Bool
//    public let locale: Locale
//    public let maximumDecimalDigits: Int
//    public let minimumDecimalDigits: Int
//
//    public var attributed: Self.Attributed {
//        Self.Attributed(baseStyle: self)
//    }
//
//    // MARK: Internal Instance Properties
//
//    internal let doubleFormatStyle: FloatingPointFormatStyle<Double>
//    internal let intFormatStyle: IntegerFormatStyle<Int>
// }
//
//// MARK: - FormatStyle
//
// extension RealFormatStyle: FormatStyle {
//
//    // MARK: Public Instance Methods
//
//    public func format(_ value: Number) -> String {
//        switch value.value {
//        case let .exactInteger(exactIntegerValue):
//            _formatExactInteger(exactIntegerValue)
//
//        case let .floatingPoint(doubleValue):
//            _formatDouble(doubleValue)
//
//        case let .fraction(fractionValue):
//            _formatFraction(fractionValue)
//        }
//    }
//
//    // MARK: Private Instance Methods
//
//    private func _formatBigInt(_ value: BigInt) -> String {
//        let magStr = String(value.magnitude)
//
//        var result = value < 0 ? "-" : ""
//
//        if magStr.count > 3 {
//            let grpSep = locale.groupingSeparator ?? ","
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
//                result.append(char)
//
//                group += 1
//            }
//        } else {
//            result += magStr
//        }
//
//        return result
//    }
//
//    private func _formatDouble(_ value: Double) -> String {
//        doubleFormatStyle.format(value)
//    }
//
//    private func _formatExactInteger(_ value: ExactInteger) -> String {
//        switch value.value {
//        case let .large(bigIntValue):
//            _formatBigInt(bigIntValue)
//
//        case let .small(intValue):
//            _formatInt(intValue)
//        }
//    }
//
//    private func _formatFraction(_ value: Fraction) -> String {
//        let isFrac = value.denominator != 1
//
//        if isFrac && displaysFractionAsDecimal {
//            return _formatDouble(value.doubleValue)
//        }
//
//        var result = _formatExactInteger(value.numerator)
//
//        if isFrac || alwaysDisplaysDenominator {
//            result += "/"
//            result += _formatExactInteger(value.denominator)
//        }
//
//        return result
//    }
//
//    private func _formatInt(_ value: Int) -> String {
//        intFormatStyle.format(value)
//    }
// }
//
//// MARK: -
//
// extension FormatStyle where Self == RealFormatStyle {
//
//    // MARK: Public Type Properties
//
//    public static var `default`: Self {
//        .init()
//    }
// }
//
//// MARK: -
//
// extension Number {
//
//    // MARK: Public Instance Methods
//
//    public func formatted() -> String {
//        RealFormatStyle().format(self)
//    }
// }
