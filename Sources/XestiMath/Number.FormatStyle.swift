// © 2025 John Gary Pusey (see LICENSE.md)

import BigInt
import Foundation

extension Number {

    // MARK: Public Nested Types

    public struct FormatStyle {

        // MARK: Public Initializers

        public init(locale: Locale = .autoupdatingCurrent,
                    minimumDecimalDigits: Int = 1,
                    maximumDecimalDigits: Int = 6,
                    alwaysDisplaysDenominator: Bool = false,
                    displaysFractionAsDecimal: Bool = false) {
            let minDigits = _clamp(0, minimumDecimalDigits, 10)
            let maxDigits = _clamp(minDigits, maximumDecimalDigits, 10)

            self.alwaysDisplaysDenominator = alwaysDisplaysDenominator
            self.displaysFractionAsDecimal = displaysFractionAsDecimal
            self.doubleFormatStyle = .init(locale: locale)
                .decimalSeparator(strategy: .always)
                .grouping(.automatic)
                .precision(.fractionLength(minDigits...maxDigits))
                .rounded(rule: .toNearestOrAwayFromZero)
            self.intFormatStyle = .init(locale: locale)
                .decimalSeparator(strategy: .automatic)
                .grouping(.automatic)
            self.locale = locale
            self.maximumDecimalDigits = maxDigits
            self.minimumDecimalDigits = minDigits
        }

        // MARK: Public Instance Properties

        public let alwaysDisplaysDenominator: Bool
        public let displaysFractionAsDecimal: Bool
        public let locale: Locale
        public let maximumDecimalDigits: Int
        public let minimumDecimalDigits: Int

        public var attributed: Self.Attributed {
            Self.Attributed(baseStyle: self)
        }

        // MARK: Internal Instance Properties

        internal let doubleFormatStyle: FloatingPointFormatStyle<Double>
        internal let intFormatStyle: IntegerFormatStyle<Int>
    }
}

// MARK: - FormatStyle

extension Number.FormatStyle: FormatStyle {

    // MARK: Public Instance Methods

    public func format(_ value: Number) -> String {
        switch value.value {
        case let .complex(cxValue):
            _formatComplex(cxValue)

        case let .real(reValue):
            _formatReal(reValue)
        }
    }

    // MARK: Private Instance Methods

    private func _formatComplex(_ value: Complex) -> String {
        var result = _formatReal(value.realPart)

        if !value.imaginaryPart.isNegative {
            result += "+"
        }

        result += _formatReal(value.imaginaryPart)
        result += "i"

        return result
    }

    private func _formatExactInteger(_ value: ExactInteger) -> String {
        switch value.value {
        case let .large(lgValue):
            _formatLarge(lgValue)

        case let .small(smValue):
            _formatSmall(smValue)
        }
    }

    private func _formatFloatingPoint(_ value: FloatingPoint) -> String {
        doubleFormatStyle.format(value.doubleValue)
    }

    private func _formatFraction(_ value: Fraction) -> String {
        let isFrac = !value.denominator.isEqual(to: .one)

        if isFrac && displaysFractionAsDecimal {
            return _formatFloatingPoint(value.floatingPointValue)
        }

        var result = _formatExactInteger(value.numerator)

        if isFrac || alwaysDisplaysDenominator {
            result += "/"
            result += _formatExactInteger(value.denominator)
        }

        return result
    }

    private func _formatLarge(_ value: BigInt) -> String {
        let magStr = String(value.magnitude)

        var result = value < 0 ? "-" : ""

        if magStr.count > 3 {
            let grpSep = locale.groupingSeparator ?? ","

            var group = (3 - (magStr.count % 3)) % 3

            for char in magStr {
                if group == 3 {
                    result += grpSep

                    group = 0
                }

                result.append(char)

                group += 1
            }
        } else {
            result += magStr
        }

        return result
    }

    private func _formatReal(_ value: Real) -> String {
        switch value.value {
        case let .exactInteger(eiValue):
            _formatExactInteger(eiValue)

        case let .floatingPoint(fpValue):
            _formatFloatingPoint(fpValue)

        case let .fraction(frValue):
            _formatFraction(frValue)
        }
    }

    private func _formatSmall(_ value: Int) -> String {
        intFormatStyle.format(value)
    }
}

// MARK: - Private Functions

private func _clamp<T: Comparable>(_ vmin: T,
                                   _ value: T,
                                   _ vmax: T) -> T {
    vmin > value ? vmin : vmax < value ? vmax : value
}

// MARK: -

extension Number {

    // MARK: Public Instance Methods

    public func formatted() -> String {
        FormatStyle().format(self)
    }
}
