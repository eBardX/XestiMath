// © 2024 John Gary Pusey (see LICENSE.md)

public protocol RealRepresentable: Codable,
                                   Comparable,
                                   CustomStringConvertible,
                                   Equatable,
                                   ExpressibleByFloatLiteral,
                                   ExpressibleByIntegerLiteral,
                                   ExpressibleByStringLiteral,
                                   Hashable {
    static var invalidMessage: String { get }

    static func isValid(_ realValue: Real) -> Bool

    init?(realValue: Real)

    init(_ realValue: Real)

    var doubleValue: Double { get }

    var exactIntegerValue: ExactInteger { get }

    var floatValue: Float { get }

    var int16Value: Int16 { get }

    var int32Value: Int32 { get }

    var int64Value: Int64 { get }

    var int8Value: Int8 { get }

    var intValue: Int { get }

    var realValue: Real { get }

    var uint16Value: UInt16 { get }

    var uint32Value: UInt32 { get }

    var uint64Value: UInt64 { get }

    var uint8Value: UInt8 { get }

    var uintValue: UInt { get }
}

// MARK: - (defaults)

extension RealRepresentable {

    // MARK: Public Initializers

    public init?(realValue: Real) {
        guard Self.isValid(realValue)
        else { return nil }

        self.init(realValue)
    }

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        realValue.doubleValue
    }

    public var exactIntegerValue: ExactInteger {
        realValue.exactIntegerValue
    }

    public var floatValue: Float {
        realValue.floatValue
    }

    public var int16Value: Int16 {
        realValue.int16Value
    }

    public var int32Value: Int32 {
        realValue.int32Value
    }

    public var int64Value: Int64 {
        realValue.int64Value
    }

    public var int8Value: Int8 {
        realValue.int8Value
    }

    public var intValue: Int {
        realValue.intValue
    }

    public var uint16Value: UInt16 {
        realValue.uint16Value
    }

    public var uint32Value: UInt32 {
        realValue.uint32Value
    }

    public var uint64Value: UInt64 {
        realValue.uint64Value
    }

    public var uint8Value: UInt8 {
        realValue.uint8Value
    }

    public var uintValue: UInt {
        realValue.uintValue
    }
}

// MARK: - Codable

extension RealRepresentable where Self: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let realValue = try container.decode(Real.self)

        self.init(realValue)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(realValue)
    }
}

// MARK: - Comparable

extension RealRepresentable where Self: Comparable {
    public static func < (lhs: Self,
                          rhs: Self) -> Bool {
        lhs.realValue < rhs.realValue
    }
}

// MARK: - CustomStringConvertible

extension RealRepresentable where Self: CustomStringConvertible {
    public var description: String {
        realValue.description
    }
}

// MARK: - Equatable

extension RealRepresentable where Self: Equatable {
    public static func == (lhs: Self,
                           rhs: Self) -> Bool {
        lhs.realValue == rhs.realValue
    }
}

// MARK: - ExpressibleByFloatLiteral

extension RealRepresentable where Self: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(Real(floatLiteral: value))
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension RealRepresentable where Self: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self.init(Real(integerLiteral: value))
    }
}

// MARK: - ExpressibleByStringLiteral

extension RealRepresentable where Self: ExpressibleByStringLiteral {
   public init(stringLiteral value: String) {
        self.init(Real(stringLiteral: value))
   }
}
