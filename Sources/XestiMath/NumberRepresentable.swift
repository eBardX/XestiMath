// © 2025 John Gary Pusey (see LICENSE.md)

public protocol NumberRepresentable: Codable,
                                     Comparable,
                                     CustomStringConvertible,
                                     Equatable,
                                     ExpressibleByFloatLiteral,
                                     ExpressibleByIntegerLiteral,
                                     ExpressibleByStringLiteral,
                                     Hashable {
    static var invalidMessage: String { get }

    static func isValid(_ numberValue: Number) -> Bool

    static func requireValid(_ numberValue: Number,
                             file: StaticString,
                             line: UInt) -> Number

    init?(numberValue: Number)

    init(_ numberValue: Number)

    var doubleValue: Double { get }

    var floatValue: Float { get }

    @available(iOS 18.0, *)
    @available(macOS 15.0, *)
    var int128Value: Int128 { get }

    var int16Value: Int16 { get }

    var int32Value: Int32 { get }

    var int64Value: Int64 { get }

    var int8Value: Int8 { get }

    var intValue: Int { get }

    var numberValue: Number { get }

    @available(iOS 18.0, *)
    @available(macOS 15.0, *)
    var uint128Value: UInt128 { get }

    var uint16Value: UInt16 { get }

    var uint32Value: UInt32 { get }

    var uint64Value: UInt64 { get }

    var uint8Value: UInt8 { get }

    var uintValue: UInt { get }
}

// MARK: - (defaults)

extension NumberRepresentable {

    // MARK: Public Type Properties

    public static var invalidMessage: String {
        "number value must be valid"
    }

    // MARK: Public Type Methods

    public static func isValid(_ numberValue: Number) -> Bool {
        true
    }

    public static func requireValid(_ numberValue: Number,
                                    file: StaticString = #file,
                                    line: UInt = #line) -> Number {
        precondition(isValid(numberValue),
                     invalidMessage,
                     file: file,
                     line: line)

        return numberValue
    }

    // MARK: Public Initializers

    public init?(numberValue: Number) {
        guard Self.isValid(numberValue)
        else { return nil }

        self.init(numberValue)
    }

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        numberValue.doubleValue
    }

    public var floatValue: Float {
        numberValue.floatValue
    }

    @available(iOS 18.0, *)
    @available(macOS 15.0, *)
    public var int128Value: Int128 {
        numberValue.int128Value
    }

    public var int16Value: Int16 {
        numberValue.int16Value
    }

    public var int32Value: Int32 {
        numberValue.int32Value
    }

    public var int64Value: Int64 {
        numberValue.int64Value
    }

    public var int8Value: Int8 {
        numberValue.int8Value
    }

    public var intValue: Int {
        numberValue.intValue
    }

    @available(iOS 18.0, *)
    @available(macOS 15.0, *)
    public var uint128Value: UInt128 {
        numberValue.uint128Value
    }

    public var uint16Value: UInt16 {
        numberValue.uint16Value
    }

    public var uint32Value: UInt32 {
        numberValue.uint32Value
    }

    public var uint64Value: UInt64 {
        numberValue.uint64Value
    }

    public var uint8Value: UInt8 {
        numberValue.uint8Value
    }

    public var uintValue: UInt {
        numberValue.uintValue
    }
}

// MARK: - Codable

extension NumberRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let numberValue = try container.decode(Number.self)

        self.init(numberValue)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(numberValue)
    }
}

// MARK: - Comparable

extension NumberRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.numberValue < rhs.numberValue
    }
}

// MARK: - CustomStringConvertible

extension NumberRepresentable where Self: CustomStringConvertible {
    public var description: String {
        numberValue.description
    }
}

// MARK: - Equatable

extension NumberRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.numberValue == rhs.numberValue
    }
}

// MARK: - ExpressibleByFloatLiteral

extension NumberRepresentable where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(Number(floatLiteral: value))
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension NumberRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(Number(integerLiteral: value))
    }
}

// MARK: - ExpressibleByStringLiteral

extension NumberRepresentable where Self: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(Number(stringLiteral: value))
    }
}
