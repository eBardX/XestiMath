// © 2024 John Gary Pusey (see LICENSE.md)

import BigInt

public enum ExactInteger {
    case large(BigInt)
    case small(Int)
}

// MARK: -

extension ExactInteger {

    // MARK: Public Initializers

    public init(_ value: Int) {
        self = .small(value)
    }

    public init(_ value: Int8) {
        self = .small(Int(value))
    }

    public init(_ value: Int16) {
        self = .small(Int(value))
    }

    public init(_ value: Int32) {
        self = .small(Int(value))
    }

    public init(_ value: Int64) {
        if value.bitWidth > Int.bitWidth {
            self = .large(BigInt(value))
        } else {
            self = .small(Int(value))
        }
    }

    public init?(_ value: String) {
        if let tmpValue = Self._parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    public init(_ value: UInt) {
        self = .small(Int(value))
    }

    public init(_ value: UInt8) {
        self = .small(Int(value))
    }

    public init(_ value: UInt16) {
        self = .small(Int(value))
    }

    public init(_ value: UInt32) {
        self = .small(Int(value))
    }

    public init(_ value: UInt64) {
        if value.bitWidth > Int.bitWidth {
            self = .large(BigInt(value))
        } else {
            self = .small(Int(value))
        }
    }
}

// MARK: -

extension ExactInteger {

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        switch self {
        case let .large(val):
            Double(val)

        case let .small(val):
            Double(val)
        }
    }

    public var floatValue: Float {
        switch self {
        case let .large(val):
            Float(val)

        case let .small(val):
            Float(val)
        }
    }

    public var int16Value: Int16 {
        switch self {
        case let .large(val):
            Int16(val)

        case let .small(val):
            Int16(val)
        }
    }

    public var int32Value: Int32 {
        switch self {
        case let .large(val):
            Int32(val)

        case let .small(val):
            Int32(val)
        }
    }

    public var int64Value: Int64 {
        switch self {
        case let .large(val):
            Int64(val)

        case let .small(val):
            Int64(val)
        }
    }

    public var int8Value: Int8 {
        switch self {
        case let .large(val):
            Int8(val)

        case let .small(val):
            Int8(val)
        }
    }

    public var intValue: Int {
        switch self {
        case let .large(val):
            Int(val)

        case let .small(val):
            val
        }
    }

    public var uint16Value: UInt16 {
        switch self {
        case let .large(val):
            UInt16(val)

        case let .small(val):
            UInt16(val)
        }
    }

    public var uint32Value: UInt32 {
        switch self {
        case let .large(val):
            UInt32(val)

        case let .small(val):
            UInt32(val)
        }
    }

    public var uint64Value: UInt64 {
        switch self {
        case let .large(val):
            UInt64(val)

        case let .small(val):
            UInt64(val)
        }
    }

    public var uint8Value: UInt8 {
        switch self {
        case let .large(val):
            UInt8(val)

        case let .small(val):
            UInt8(val)
        }
    }

    public var uintValue: UInt {
        switch self {
        case let .large(val):
            UInt(val)

        case let .small(val):
            UInt(val)
        }
    }
}

// MARK: -

extension ExactInteger {

    // MARK: Internal Type Methods

    internal static func coerce(_ lhs: Self,
                                _ rhs: Self) -> (Self, Self) {
        switch (lhs, rhs) {
        case (.large, .large),
            (.small, .small):
            (lhs, rhs)

        case let (.large, .small(rval)):
            (lhs, .large(BigInt(rval)))

        case let (.small(lval), .large):
            (.large(BigInt(lval)), rhs)
        }
    }

    // MARK: Private Type Methods

    private static func _parse(_ value: String) -> Self? {
        guard let biValue = BigInt(value)
        else { return nil }

        if biValue.bitWidth > Int.bitWidth {
            return .large(biValue)
        } else {
            return .small(Int(biValue))
        }
    }
}

// MARK: - Codable

extension ExactInteger: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let tmpValue = Self._parse(stringValue) {
            self = tmpValue
        } else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid exact integer value")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(description)
    }
}

// MARK: - Comparable

extension ExactInteger: Comparable {
}

// MARK: - CustomPlaygroundDisplayConvertible

extension ExactInteger: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        switch self {
        case let .large(val):
            "large<\(val.playgroundDescription)>"

        case let .small(val):
            "small<\(val.description)>"
        }
    }
}

// MARK: - CustomStringConvertible

extension ExactInteger: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .large(val):
            val.description

        case let .small(val):
            val.description
        }
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension ExactInteger: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension ExactInteger: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!   // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension ExactInteger: Hashable {
}
