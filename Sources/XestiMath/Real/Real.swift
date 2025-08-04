// © 2024—2025 John Gary Pusey (see LICENSE.md)

public struct Real: Sendable {

    // MARK: Internal Initializers

    internal init(exactInteger value: ExactInteger) {
        self.value = .exactInteger(value)
    }

    internal init(floatingPoint value: Double) {
        self.value = .floatingPoint(value)
    }

    internal init(fraction value: Fraction) {
        self.value = .fraction(value)
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

// MARK: -

extension Real {

    // MARK: Public Initializers

    public init(_ numerator: ExactInteger,
                _ denominator: ExactInteger) {
        self.init(fraction: Fraction(numerator, denominator))
    }

    public init(_ numerator: Int,
                _ denominator: Int) {
        self.init(fraction: Fraction(numerator, denominator))
    }

    public init(_ numerator: Int64,
                _ denominator: Int64) {
        self.init(fraction: Fraction(numerator, denominator))
    }

    public init(_ value: Double) {
        self.init(floatingPoint: value)
    }

    public init(_ value: Float) {
        self.init(floatingPoint: Double(value))
    }

    public init?<S: StringProtocol>(_ value: S) {
        if let tmpValue = Self.parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    public init<T: BinaryInteger>(_ value: T) {
        self.init(exactInteger: ExactInteger(value))
    }
}

// MARK: -

extension Real {

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        switch value {
        case let .exactInteger(val):
            return val.doubleValue

        case let .floatingPoint(val):
            return val

        case let .fraction(val):
            return val.doubleValue
        }
    }

//    public var exactIntegerValue: ExactInteger {
//        precondition(isExactInteger,
//                     "\(self) is not an exact integer")
//
//        switch value {
//        case let .exactInteger(val):
//            return val
//
//        case .floatingPoint:
//            return 0
//
//        case let .fraction(val):
//            return val.numerator
//        }
//    }

    public var floatValue: Float {
        switch value {
        case let .exactInteger(val):
            return val.floatValue

        case let .floatingPoint(val):
            return Float(val)

        case let .fraction(val):
            return val.floatValue
        }
    }

    public var int16Value: Int16 {
        switch value {
        case let .exactInteger(val):
            return val.int16Value

        case let .floatingPoint(val):
            return Int16(val)

        case let .fraction(val):
            return val.int16Value
        }
    }

    public var int32Value: Int32 {
        switch value {
        case let .exactInteger(val):
            return val.int32Value

        case let .floatingPoint(val):
            return Int32(val)

        case let .fraction(val):
            return val.int32Value
        }
    }

    public var int64Value: Int64 {
        switch value {
        case let .exactInteger(val):
            return val.int64Value

        case let .floatingPoint(val):
            return Int64(val)

        case let .fraction(val):
            return val.int64Value
        }
    }

    public var int8Value: Int8 {
        switch value {
        case let .exactInteger(val):
            return val.int8Value

        case let .floatingPoint(val):
            return Int8(val)

        case let .fraction(val):
            return val.int8Value
        }
    }

    public var intValue: Int {
        switch value {
        case let .exactInteger(val):
            return val.intValue

        case let .floatingPoint(val):
            return Int(val)

        case let .fraction(val):
            return val.intValue
        }
    }

//    public var isExactInteger: Bool {
//        switch value {
//        case .exactInteger:
//            return true
//
//        case let .floatingPoint(val):
//            return Double(Int(val)) == val
//
//        case let .fraction(val):
//            return val.isExactInteger
//        }
//    }

    public var uint16Value: UInt16 {
        switch value {
        case let .exactInteger(val):
            return val.uint16Value

        case let .floatingPoint(val):
            return UInt16(val)

        case let .fraction(val):
            return val.uint16Value
        }
    }

    public var uint32Value: UInt32 {
        switch value {
        case let .exactInteger(val):
            return val.uint32Value

        case let .floatingPoint(val):
            return UInt32(val)

        case let .fraction(val):
            return val.uint32Value
        }
    }

    public var uint64Value: UInt64 {
        switch value {
        case let .exactInteger(val):
            return val.uint64Value

        case let .floatingPoint(val):
            return UInt64(val)

        case let .fraction(val):
            return val.uint64Value
        }
    }

    public var uint8Value: UInt8 {
        switch value {
        case let .exactInteger(val):
            return val.uint8Value

        case let .floatingPoint(val):
            return UInt8(val)

        case let .fraction(val):
            return val.uint8Value
        }
    }

    public var uintValue: UInt {
        switch value {
        case let .exactInteger(val):
            return val.uintValue

        case let .floatingPoint(val):
            return UInt(val)

        case let .fraction(val):
            return val.uintValue
        }
    }
}

// MARK: -

extension Real {

    // MARK: Internal Type Methods

    internal static func checkInteger(_ value: Self,
                                      file: StaticString = #file,
                                      line: UInt = #line) -> Self {
        precondition(value.isInteger,
                     "\(value) is not an integer",
                     file: file,
                     line: line)

        return value
    }

    internal static func checkRational(_ value: Self,
                                       file: StaticString = #file,
                                       line: UInt = #line) -> Self {
        precondition(value.isRational,
                     "\(value) is not a rational number",
                     file: file,
                     line: line)

        return value
    }

    internal static func coerce(_ lhs: Self,
                                _ rhs: Self) -> (Self, Self) {
        switch (lhs.value, rhs.value) {
        case (.exactInteger, .exactInteger),
            (.floatingPoint, .floatingPoint),
            (.fraction, .fraction):
            return (lhs, rhs)

        case let (.exactInteger(lval), .floatingPoint):
            return (Self(floatingPoint: lval.doubleValue), rhs)

        case let (.exactInteger(lval), .fraction):
            return (Self(fraction: Fraction(lval, 1, false)), rhs)

        case let (.floatingPoint, .exactInteger(rval)):
            return (lhs, Self(floatingPoint: rval.doubleValue))

        case let (.floatingPoint, .fraction(rval)):
            return (lhs, Self(floatingPoint: rval.doubleValue))

        case let (.fraction, .exactInteger(rval)):
            return (lhs, Self(fraction: Fraction(rval, 1, false)))

        case let (.fraction(lval), .floatingPoint):
            return (Self(floatingPoint: lval.doubleValue), rhs)
        }
    }
}

// MARK: - Codable

extension Real: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let tmpValue = Self.parse(stringValue) {
            self = tmpValue
        } else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid real value")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(description)
    }
}

// MARK: - Comparable

extension Real: Comparable {
}

// MARK: - CustomStringConvertible

extension Real: CustomStringConvertible {
    public var description: String {
        switch value {
        case let .exactInteger(val):
            return val.description

        case let .floatingPoint(val):
            return val.description

        case let .fraction(val):
            return val.description
        }
    }
}

// MARK: - ExpressibleByFloatLiteral

extension Real: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Real: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension Real: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!   // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension Real: Hashable {
}
