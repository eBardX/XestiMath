// © 2024 John Gary Pusey (see LICENSE.md)

public enum Real {
    case exactInteger(ExactInteger)
    case floatingPoint(Double)
    case fraction(Fraction)
}

// MARK: -

extension Real {

    // MARK: Public Initializers

    public init(_ numerator: ExactInteger,
                _ denominator: ExactInteger) {
        self = .fraction(Fraction(numerator, denominator))
    }

    public init(_ numerator: Int,
                _ denominator: Int) {
        self = .fraction(Fraction(numerator, denominator))
    }

    public init(_ numerator: Int64,
                _ denominator: Int64) {
        self = .fraction(Fraction(numerator, denominator))
    }

    public init(_ value: Double) {
        self = .floatingPoint(value)
    }

    public init(_ value: Float) {
        self = .floatingPoint(Double(value))
    }

    public init(_ value: Int) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: Int8) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: Int16) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: Int32) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: Int64) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: UInt) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: UInt8) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: UInt16) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: UInt32) {
        self = .exactInteger(ExactInteger(value))
    }

    public init(_ value: UInt64) {
        self = .exactInteger(ExactInteger(value))
    }

    public init?(_ value: String) {
        if let tmpValue = Self._parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }
}

// MARK: -

extension Real {

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        switch self {
        case let .exactInteger(val):
            return val.doubleValue

        case let .floatingPoint(val):
            return val

        case let .fraction(val):
            return val.doubleValue
        }
    }

    public var floatValue: Float {
        switch self {
        case let .exactInteger(val):
            return val.floatValue

        case let .floatingPoint(val):
            return Float(val)

        case let .fraction(val):
            return val.floatValue
        }
    }

    public var exactIntegerValue: ExactInteger {
        precondition(isExactInteger,
                     "\(self) is not an exact integer")

        switch self {
        case let .exactInteger(val):
            return val

        case let .floatingPoint(val):
            return .small(Int(val))   // let ExactInteger figure it out?

        case let .fraction(val):
            return val.numerator
        }
    }

    public var int16Value: Int16 {
        switch self {
        case let .exactInteger(val):
            return val.int16Value

        case let .floatingPoint(val):
            return Int16(val)

        case let .fraction(val):
            return val.int16Value
        }
    }

    public var int32Value: Int32 {
        switch self {
        case let .exactInteger(val):
            return val.int32Value

        case let .floatingPoint(val):
            return Int32(val)

        case let .fraction(val):
            return val.int32Value
        }
    }

    public var int64Value: Int64 {
        switch self {
        case let .exactInteger(val):
            return val.int64Value

        case let .floatingPoint(val):
            return Int64(val)

        case let .fraction(val):
            return val.int64Value
        }
    }

    public var int8Value: Int8 {
        switch self {
        case let .exactInteger(val):
            return val.int8Value

        case let .floatingPoint(val):
            return Int8(val)

        case let .fraction(val):
            return val.int8Value
        }
    }

    public var intValue: Int {
        switch self {
        case let .exactInteger(val):
            return val.intValue

        case let .floatingPoint(val):
            return Int(val)

        case let .fraction(val):
            return val.intValue
        }
    }

    public var uint16Value: UInt16 {
        switch self {
        case let .exactInteger(val):
            return val.uint16Value

        case let .floatingPoint(val):
            return UInt16(val)

        case let .fraction(val):
            return val.uint16Value
        }
    }

    public var uint32Value: UInt32 {
        switch self {
        case let .exactInteger(val):
            return val.uint32Value

        case let .floatingPoint(val):
            return UInt32(val)

        case let .fraction(val):
            return val.uint32Value
        }
    }

    public var uint64Value: UInt64 {
        switch self {
        case let .exactInteger(val):
            return val.uint64Value

        case let .floatingPoint(val):
            return UInt64(val)

        case let .fraction(val):
            return val.uint64Value
        }
    }

    public var uint8Value: UInt8 {
        switch self {
        case let .exactInteger(val):
            return val.uint8Value

        case let .floatingPoint(val):
            return UInt8(val)

        case let .fraction(val):
            return val.uint8Value
        }
    }

    public var uintValue: UInt {
        switch self {
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
        switch (lhs, rhs) {
        case (.exactInteger, .exactInteger),
            (.floatingPoint, .floatingPoint),
            (.fraction, .fraction):
            return (lhs, rhs)

        case let (.exactInteger(lval), .floatingPoint):
            return (.floatingPoint(lval.doubleValue), rhs)

        case let (.exactInteger(lval), .fraction):
            return (.fraction(Fraction(lval, 1, false)), rhs)

        case let (.floatingPoint, .exactInteger(rval)):
            return (lhs, .floatingPoint(rval.doubleValue))

        case let (.floatingPoint, .fraction(rval)):
            return (lhs, .floatingPoint(rval.doubleValue))

        case let (.fraction, .exactInteger(rval)):
            return (lhs, .fraction(Fraction(rval, 1, false)))

        case let (.fraction(lval), .floatingPoint):
            return (.floatingPoint(lval.doubleValue), rhs)
        }
    }

    // MARK: Internal Instance Properties

    internal var isExactInteger: Bool {
        switch self {
        case .exactInteger:
            return true

        case let .floatingPoint(val):
            return Double(Int(val)) == val

        case let .fraction(val):
            return val.isExactInteger
        }
    }

    // MARK: Private Type Methods

    private static func _parse(_ value: String) -> Self? {
        if let tmpValue = ExactInteger(value) {
            return .exactInteger(tmpValue)
        } else if let tmpValue = Fraction(value) {
            return .fraction(tmpValue)
        } else if let tmpValue = Double(value) {
            return .floatingPoint(tmpValue)
        } else {
            return nil
        }
    }
}

// MARK: - Codable

extension Real: Codable {
}

// MARK: - Comparable

extension Real: Comparable {
}

// MARK: - CustomStringConvertible

extension Real: CustomStringConvertible {
    public var description: String {
        switch self {
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
