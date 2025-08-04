// © 2024–2025 John Gary Pusey (see LICENSE.md)

public struct Fraction: Sendable {

    // MARK: Public Initializers

    public init(_ numerator: ExactInteger,
                _ denominator: ExactInteger = 1) {
        self.init(numerator,
                  denominator,
                  true)
    }

    public init(_ numerator: Int,
                _ denominator: Int = 1) {
        self.init(ExactInteger(numerator),
                  ExactInteger(denominator),
                  true)
    }

    public init(_ numerator: Int64,
                _ denominator: Int64 = 1) {
        self.init(ExactInteger(numerator),
                  ExactInteger(denominator),
                  true)
    }

    public init?<S: StringProtocol>(_ value: S) {
        if let tmpValue = Self.parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    // MARK: Public Instance Properties

    public let denominator: ExactInteger
    public let numerator: ExactInteger

    // MARK: Internal Initializers

    internal init(_ numerator: ExactInteger,
                  _ denominator: ExactInteger,
                  _ reduce: Bool) {
        var num = numerator
        var den = denominator

        precondition(den != 0,
                     "denominator must be a nonzero exact integer")

        if reduce && den != 1 {
            if den < 0 {
                num = -num
                den = -den
            }

            if num != 0 {
                let tmp = gcd(num, den)

                if tmp != 1 {
                    num = quotient(num, tmp)
                    den = quotient(den, tmp)
                }
            } else {
                den = 1
            }
        }

        self.denominator = den
        self.numerator = num
    }
}

// MARK: -

extension Fraction {

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        numerator.doubleValue / denominator.doubleValue
    }

    public var floatValue: Float {
        numerator.floatValue / denominator.floatValue
    }

    public var int16Value: Int16 {
        numerator.int16Value / denominator.int16Value
    }

    public var int32Value: Int32 {
        numerator.int32Value / denominator.int32Value
    }

    public var int64Value: Int64 {
        numerator.int64Value / denominator.int64Value
    }

    public var int8Value: Int8 {
        numerator.int8Value / denominator.int8Value
    }

    public var intValue: Int {
        numerator.intValue / denominator.intValue
    }

    public var uint16Value: UInt16 {
        numerator.uint16Value / denominator.uint16Value
    }

    public var uint32Value: UInt32 {
        numerator.uint32Value / denominator.uint32Value
    }

    public var uint64Value: UInt64 {
        numerator.uint64Value / denominator.uint64Value
    }

    public var uint8Value: UInt8 {
        numerator.uint8Value / denominator.uint8Value
    }

    public var uintValue: UInt {
        numerator.uintValue / denominator.uintValue
    }
}

// MARK: - Codable

extension Fraction: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let tmpValue = Self.parse(stringValue) {
            self = tmpValue
        } else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid fraction value")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(description)
    }
}

// MARK: - Comparable

extension Fraction: Comparable {
}

// MARK: - CustomStringConvertible

extension Fraction: CustomStringConvertible {
    public var description: String {
        if denominator != 1 {
            numerator.description + "/" + denominator.description
        } else {
            numerator.description
        }
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Fraction: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension Fraction: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!   // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension Fraction: Hashable {
}
