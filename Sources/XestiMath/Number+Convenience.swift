// © 2025 John Gary Pusey (see LICENSE.md)

import BigInt

extension Number {

    // MARK: Public Type Properties

    public static let nan              = Self(.real(.nan))
    public static let negativeInfinity = Self(.real(.negativeInfinity))
    public static let pi               = Self(.real(.pi))
    public static let positiveInfinity = Self(.real(.positiveInfinity))

    // MARK: Public Initializers

    public init?<S: StringProtocol>(_ value: S) {
        if let tmpValue = Self.parse(value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    public init<T: BinaryFloatingPoint>(_ value: T) {
        self.init(.real(Real(value)))
    }

    public init<T: BinaryInteger>(_ value: T) {
        self.init(.real(Real(value)))
    }

    public init(magnitude: Self,
                angle: Self) {
        self.init(.complex(Complex.fromPolar(magnitude: magnitude.toReal(),
                                             angle: angle.toReal())))
    }

    public init<T: BinaryFloatingPoint>(magnitude: T,
                                        angle: T) {
        self.init(.complex(Complex.fromPolar(magnitude: Real(magnitude),
                                             angle: Real(angle))))
    }

    public init<T: BinaryInteger>(magnitude: T,
                                  angle: T) {
        self.init(.complex(Complex.fromPolar(magnitude: Real(magnitude),
                                             angle: Real(angle))))
    }

    public init(numerator: Self,
                denominator: Self) {
        self.init(.real(Real(numerator: numerator.toExactInteger(),
                             denominator: denominator.toExactInteger())))
    }

    public init<T: BinaryInteger>(numerator: T,
                                  denominator: T) {
        self.init(.real(Real(numerator: ExactInteger(numerator),
                             denominator: ExactInteger(denominator))))
    }

    public init(real: Self,
                imaginary: Self) {
        self.init(.complex(Complex(real: real.toReal(),
                                   imaginary: imaginary.toReal())))
    }

    public init<T: BinaryFloatingPoint>(real: T,
                                        imaginary: T) {
        self.init(.complex(Complex(real: Real(real),
                                   imaginary: Real(imaginary))))
    }

    public init<T: BinaryInteger>(real: T,
                                  imaginary: T) {
        self.init(.complex(Complex(real: Real(real),
                                   imaginary: Real(imaginary))))
    }

    // MARK: Public Instance Properties

    public var doubleValue: Double {
        toReal().floatingPointValue.doubleValue
    }

    public var floatValue: Float {
        toReal().floatingPointValue.floatValue
    }

    @available(iOS 18.0, macOS 15.0, *)
    public var int128Value: Int128 {
        toReal().exactIntegerValue.int128Value
    }

    public var int16Value: Int16 {
        toReal().exactIntegerValue.int16Value
    }

    public var int32Value: Int32 {
        toReal().exactIntegerValue.int32Value
    }

    public var int64Value: Int64 {
        toReal().exactIntegerValue.int64Value
    }

    public var int8Value: Int8 {
        toReal().exactIntegerValue.int8Value
    }

    public var intValue: Int {
        toReal().exactIntegerValue.intValue
    }

    @available(iOS 18.0, macOS 15.0, *)
    public var uint128Value: UInt128 {
        toReal().exactIntegerValue.uint128Value
    }

    public var uint16Value: UInt16 {
        toReal().exactIntegerValue.uint16Value
    }

    public var uint32Value: UInt32 {
        toReal().exactIntegerValue.uint32Value
    }

    public var uint64Value: UInt64 {
        toReal().exactIntegerValue.uint64Value
    }

    public var uint8Value: UInt8 {
        toReal().exactIntegerValue.uint8Value
    }

    public var uintValue: UInt {
        toReal().exactIntegerValue.uintValue
    }
}
