// © 2024–2025 John Gary Pusey (see LICENSE.md)

import BigInt

public struct ExactInteger: Sendable {

    // MARK: Internal Initializers

    internal init(large value: BigInt) {
        self.value = .large(value)
    }

    internal init(small value: Int) {
        self.value = .small(value)
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

// MARK: -

extension ExactInteger {

    // MARK: Public Initializers

    public init?<S: StringProtocol>(_ value: S) {
        if let tmpValue = Self.parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    public init<T: BinaryInteger>(_ value: T) {
        if let intValue = Int(exactly: value) {
            self.init(small: intValue)
        } else {
            self.init(large: BigInt(value))
        }
    }
}

// MARK: -

extension ExactInteger {

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        switch value {
        case let .large(val):
            Double(val)

        case let .small(val):
            Double(val)
        }
    }

    public var floatValue: Float {
        switch value {
        case let .large(val):
            Float(val)

        case let .small(val):
            Float(val)
        }
    }

    public var int16Value: Int16 {
        switch value {
        case let .large(val):
            Int16(val)

        case let .small(val):
            Int16(val)
        }
    }

    public var int32Value: Int32 {
        switch value {
        case let .large(val):
            Int32(val)

        case let .small(val):
            Int32(val)
        }
    }

    public var int64Value: Int64 {
        switch value {
        case let .large(val):
            Int64(val)

        case let .small(val):
            Int64(val)
        }
    }

    public var int8Value: Int8 {
        switch value {
        case let .large(val):
            Int8(val)

        case let .small(val):
            Int8(val)
        }
    }

    public var intValue: Int {
        switch value {
        case let .large(val):
            Int(val)

        case let .small(val):
            val
        }
    }

    public var uint16Value: UInt16 {
        switch value {
        case let .large(val):
            UInt16(val)

        case let .small(val):
            UInt16(val)
        }
    }

    public var uint32Value: UInt32 {
        switch value {
        case let .large(val):
            UInt32(val)

        case let .small(val):
            UInt32(val)
        }
    }

    public var uint64Value: UInt64 {
        switch value {
        case let .large(val):
            UInt64(val)

        case let .small(val):
            UInt64(val)
        }
    }

    public var uint8Value: UInt8 {
        switch value {
        case let .large(val):
            UInt8(val)

        case let .small(val):
            UInt8(val)
        }
    }

    public var uintValue: UInt {
        switch value {
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
        switch (lhs.value, rhs.value) {
        case (.large, .large),
            (.small, .small):
            (lhs, rhs)

        case let (.large, .small(rval)):
            (lhs, Self(large: BigInt(rval)))

        case let (.small(lval), .large):
            (Self(large: BigInt(lval)), rhs)
        }
    }
}

// MARK: - Codable

extension ExactInteger: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let tmpValue = Self.parse(stringValue) {
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
        switch value {
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
        switch value {
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
