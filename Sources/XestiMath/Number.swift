// © 2025 John Gary Pusey (see LICENSE.md)

public struct Number {

    // MARK: Internal Initializers

    internal init(_ value: Value) {
        self.value = value
    }

    // MARK: Internal Instance Properties

    internal let value: Value
}

// MARK: - Codable

extension Number: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)

        if let tmpValue = Self.parse(stringValue) {
            self = tmpValue
        } else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid number value")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(description)
    }
}

// MARK: - Comparable

extension Number: Comparable {
}

// MARK: - CustomDebugStringConvertible

extension Number: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch value {
        case let .complex(val):
            val.debugDescription

        case let .real(val):
            val.debugDescription
        }
    }
}

// MARK: - CustomStringConvertible

extension Number: CustomStringConvertible {
    public var description: String {
        switch value {
        case let .complex(val):
            val.description

        case let .real(val):
            val.description
        }
    }
}

// MARK: - Equatable

extension Number: Equatable {
}

// MARK: - ExpressibleByFloatLiteral

extension Number: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Number: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(value)
    }
}

// MARK: - ExpressibleByStringLiteral

extension Number: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)!   // swiftlint:disable:this force_unwrapping
    }
}

// MARK: - Hashable

extension Number: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
}

// MARK: - Sendable

extension Number: Sendable {
}
