// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

public enum RealFormatStyleConfiguration {
    internal struct Collection {
        internal var decimalSeparatorStrategy: DecimalSeparatorDisplayStrategy?
        internal var group: Grouping?
        internal var precision: Precision?
        internal var rounding: RoundingRule?
        internal var roundingIncrement: RoundingIncrement?
        internal var signDisplayStrategy: SignDisplayStrategy?
    }

    public typealias RoundingRule = FloatingPointRoundingRule

    public struct DecimalSeparatorDisplayStrategy {
        internal enum Option: Int {
            case automatic
            case always
        }

        internal var option: Option

        // "1.1", "1"
        public static var automatic: Self {
            .init(option: .automatic)
        }

        // "1.1", "1."
        public static var always: Self { .init(option: .always) }

        public var description: String {
            switch option {
            case .automatic:
                return "automatic"

            case .always:
                return "always"
            }
        }
    }

    public struct Grouping {
        internal enum Option: Int {
            case automatic
            case hidden
        }

        internal var option: Option

        public static var automatic: Self { .init(option: .automatic) }
        public static var never: Self { .init(option: .hidden) }

        public var description: String {
            switch option {
            case .automatic:
                return "automatic"

            case .hidden:
                return "never"
            }
        }
    }

    public struct Precision {
        internal enum Option {
            case integerAndFractionalLength(minInt: Int?, maxInt: Int?, minFraction: Int?, maxFraction: Int?)
            case significantDigits(min: Int, max: Int?)
        }

        internal var option: Option

        // The maximum total length that ICU allows is 999.
        // We take one off to reserve one character for the non-zero digit skeleton (the "0" skeleton in the number format)
        internal static let validPartLength = 0..<999
        internal static let validSignificantDigits = 1..<999

        public static func significantDigits(_ digits: Int) -> Self {
            return Precision(option: .significantDigits(min: digits,
                                                        max: digits))
        }

        public static func fractionLength<R: RangeExpression>(_ limits: R) -> Self where R.Bound == Int {
            let (minFrac, maxFrac) = limits.clampedLowerAndUpperBounds(validPartLength)

            return Precision(option: .integerAndFractionalLength(minInt: nil,
                                                                 maxInt: nil,
                                                                 minFraction: minFrac,
                                                                 maxFraction: maxFrac))
        }

        public static func fractionLength(_ length: Int) -> Self {
            return Precision(option: .integerAndFractionalLength(minInt: nil,
                                                                 maxInt: nil,
                                                                 minFraction: length,
                                                                 maxFraction: length))
        }

        // maxInt 2: 1997 -> 97
        // minInt 5: 1997 -> 01997
        // maxFrac 2: 0.125 -> 0.12
        // minFrac 4: 0.125 -> 0.1250
        public static func integerAndFractionLength<R1: RangeExpression, R2: RangeExpression>(integerLimits: R1,
                                                                                              fractionLimits: R2) -> Self where R1.Bound == Int, R2.Bound == Int {
            let (minInt, maxInt) =  integerLimits.clampedLowerAndUpperBounds(validPartLength)
            let (minFrac, maxFrac) = fractionLimits.clampedLowerAndUpperBounds(validPartLength)

            return Precision(option: .integerAndFractionalLength(minInt: minInt,
                                                                 maxInt: maxInt,
                                                                 minFraction: minFrac,
                                                                 maxFraction: maxFrac))
        }

        public static func integerAndFractionLength(integer: Int, fraction: Int) -> Self {
            return Precision(option: .integerAndFractionalLength(minInt: integer,
                                                                 maxInt: integer,
                                                                 minFraction: fraction,
                                                                 maxFraction: fraction))
        }

        public static func integerLength<R: RangeExpression>(_ limits: R) -> Self {
            let (minInt, maxInt) = limits.clampedLowerAndUpperBounds(validPartLength)

            return Precision(option: .integerAndFractionalLength(minInt: minInt,
                                                                 maxInt: maxInt,
                                                                 minFraction: nil,
                                                                 maxFraction: nil))
        }

        public static func integerLength(_ length: Int) -> Self {
            return Precision(option: .integerAndFractionalLength(minInt: length,
                                                                 maxInt: length,
                                                                 minFraction: nil,
                                                                 maxFraction: nil))
        }

        // min 3, max 3: 12345 -> 12300
        // min 3, max 3: 0.12345 -> 0.123
        // min 2, max 4: 3.14159 -> 3.142
        // min 2, max 4: 1.23004 -> 1.23
        // ^ Trailing zero digits to the right of the decimal separator are suppressed after the minimum number of significant digits have been shown

        public static func significantDigits<R: RangeExpression>(_ limits: R) -> Self where R.Bound == Int {
            let (lower, upper) = limits.clampedLowerAndUpperBounds(validSignificantDigits)

            return Precision(option: .significantDigits(min: lower ?? validSignificantDigits.lowerBound,
                                                        max: upper))
        }
    }

    internal enum RoundingIncrement {
        case integer(value: Int)
        case floatingPoint(value: Double)

        internal var description: String {
            switch self {
            case let .integer(value):
                return String(value)

            case let .floatingPoint(value):
                return String(value)
            }
        }
    }

    public struct SignDisplayStrategy {
        internal enum Option: Int {
            case always
            case hidden
        }

        internal var positive: Option
        internal var negative: Option
        internal var zero: Option

        // Show the minus sign on negative numbers, and do not show the sign on positive numbers or zero
        public static var automatic: Self {
            .init(positive: .hidden,
                  negative: .always,
                  zero: .hidden)
        }

        public static var never: Self {
            .init(positive: .hidden,
                  negative: .hidden,
                  zero: .hidden)
        }

        // Show the minus sign on negative numbers and the plus sign on positive numbers, and zero if specified
        public static func always(includingZero: Bool = true) -> Self {
            .init(positive: .always,
                  negative: .always,
                  zero: includingZero ? .always : .hidden)
        }

        public var description: String {
            switch positive {
            case .always:
                switch zero {
                case .always:
                    return "always(includingZero: true)"

                case .hidden:
                    return "always(includingZero: false)"
                }
            case .hidden:
                switch negative {
                case .always:
                    return "automatic"

                case .hidden:
                    return "never"
                }
            }
        }
    }
}
