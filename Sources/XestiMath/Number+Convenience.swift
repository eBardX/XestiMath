// © 2025—2026 John Gary Pusey (see LICENSE.md)

private import BigInt

extension Number {

    // MARK: Public Type Properties

    /// A NaN.
    ///
    /// A NaN compares not equal, not greater than, and not less than every
    /// number, including itself. Passing a NaN to an operation generally
    /// results in NaN.
    public static let nan = Self(.real(.nan))

    /// Negative infinity.
    ///
    /// Negative infinity compares less than all finite numbers.
    public static let negativeInfinity = Self(.real(.negativeInfinity))

    /// The mathematical constant pi (π), approximately equal to 3.14159.
    public static let pi = Self(.real(.pi))

    /// Positive infinity.
    ///
    /// Positive infinity compares greater than all finite numbers.
    public static let positiveInfinity = Self(.real(.positiveInfinity))

    // MARK: Public Initializers

    /// Creates a new number from the provided string value.
    ///
    /// The string value is parsed with ``parse(input:)``. If it is in an
    /// invalid format, the result is `nil`.
    ///
    /// - Parameter value:  The string value to parse.
    public init?<S: StringProtocol>(_ value: S) {
        if let tmpValue = Self.parse(input: value) {
            self = tmpValue
        } else {
            return nil
        }
    }

    /// Creates a new number from the provided floating-point value.
    ///
    /// - Parameter value:  The floating-point value to convert.
    public init<T: BinaryFloatingPoint>(_ value: T) {
        self.init(.real(Real(value)))
    }

    /// Creates a new number from the provided integer value.
    ///
    /// - Parameter value:  The integer value to convert.
    public init<T: BinaryInteger>(_ value: T) {
        self.init(.real(Real(value)))
    }

    /// Creates a new complex number from the provided polar coordinates.
    ///
    /// - Parameter magnitude:  The magnitude to convert.
    /// - Parameter angle:      The angle to convert.
    public init(magnitude: Self,
                angle: Self) {
        self.init(.complex(Complex.fromPolar(magnitude: magnitude.checkReal(),
                                             angle: angle.checkReal())))
    }

    /// Creates a new complex number from the provided floating-point polar
    /// coordinates.
    ///
    /// - Parameter magnitude:  The floating-point magnitude to convert.
    /// - Parameter angle:      The floating-point angle to convert.
    public init<T: BinaryFloatingPoint>(magnitude: T,
                                        angle: T) {
        self.init(.complex(Complex.fromPolar(magnitude: Real(magnitude),
                                             angle: Real(angle))))
    }

    /// Creates a new complex number from the provided integer polar
    /// coordinates.
    ///
    /// - Parameter magnitude:  The integer magnitude to convert.
    /// - Parameter angle:      The integer angle to convert.
    public init<T: BinaryInteger>(magnitude: T,
                                  angle: T) {
        self.init(.complex(Complex.fromPolar(magnitude: Real(magnitude),
                                             angle: Real(angle))))
    }

    /// Creates a new rational number from the provided numerator and
    /// denominator.
    ///
    /// - Parameter numerator:      The numerator to convert.
    /// - Parameter denominator:    The denominator to convert.
    public init(numerator: Self,
                denominator: Self) {
        self.init(.real(Real(numerator: numerator.checkExactInteger(),
                             denominator: denominator.checkExactInteger())))
    }

    /// Creates a new rational number from the provided integer numerator and
    /// denominator.
    ///
    /// - Parameter numerator:      The integer numerator to convert.
    /// - Parameter denominator:    The integer denominator to convert.
    public init<T: BinaryInteger>(numerator: T,
                                  denominator: T) {
        self.init(.real(Real(numerator: ExactInteger(numerator),
                             denominator: ExactInteger(denominator))))
    }

    /// Creates a new complex number from the provided rectangular coordinates.
    ///
    /// - Parameter realPart:       The real part to convert.
    /// - Parameter imaginaryPart:  The imaginary part to convert.
    public init(realPart: Self,
                imaginaryPart: Self) {
        self.init(.complex(Complex(realPart: realPart.checkReal(),
                                   imaginaryPart: imaginaryPart.checkReal())))
    }

    /// Creates a new complex number from the provided floating-point
    /// rectangular coordinates.
    ///
    /// - Parameter realPart:       The floating-point real part to convert.
    /// - Parameter imaginaryPart:  The floating-point imaginary part to
    ///                             convert.
    public init<T: BinaryFloatingPoint>(realPart: T,
                                        imaginaryPart: T) {
        self.init(.complex(Complex(realPart: Real(realPart),
                                   imaginaryPart: Real(imaginaryPart))))
    }

    /// Creates a new complex number from the provided integer rectangular
    /// coordinates.
    ///
    /// - Parameter realPart:       The integer real part to convert.
    /// - Parameter imaginaryPart:  The integer imaginary part to convert.
    public init<T: BinaryInteger>(realPart: T,
                                  imaginaryPart: T) {
        self.init(.complex(Complex(realPart: Real(realPart),
                                   imaginaryPart: Real(imaginaryPart))))
    }

    // MARK: Public Instance Properties

    /// The number converted to a `Double` value.
    public var doubleValue: Double {
        checkReal().floatingPointValue.doubleValue
    }

    /// The number converted to a `Float` value.
    public var floatValue: Float {
        checkReal().floatingPointValue.floatValue
    }

    /// The number converted to an `Int128` value.
    @available(iOS 18.0, macOS 15.0, *)
    public var int128Value: Int128 {
        checkExactInteger().int128Value
    }

    /// The number converted to an `Int16` value.
    public var int16Value: Int16 {
        checkExactInteger().int16Value
    }

    /// The number converted to an `Int32` value.
    public var int32Value: Int32 {
        checkExactInteger().int32Value
    }

    /// The number value converted to an `Int64` value.
    public var int64Value: Int64 {
        checkExactInteger().int64Value
    }

    /// The number converted to an `Int8` value.
    public var int8Value: Int8 {
        checkExactInteger().int8Value
    }

    /// The number converted to an `Int` value.
    public var intValue: Int {
        checkExactInteger().intValue
    }

    /// The number converted to a `UInt128` value.
    @available(iOS 18.0, macOS 15.0, *)
    public var uint128Value: UInt128 {
        checkExactInteger().uint128Value
    }

    /// The number converted to a `UInt16` value.
    public var uint16Value: UInt16 {
        checkExactInteger().uint16Value
    }

    /// The number converted to a `UInt32` value.
    public var uint32Value: UInt32 {
        checkExactInteger().uint32Value
    }

    /// The number converted to a `UInt64` value.
    public var uint64Value: UInt64 {
        checkExactInteger().uint64Value
    }

    /// The number converted to a `UInt8` value.
    public var uint8Value: UInt8 {
        checkExactInteger().uint8Value
    }

    /// The number converted to a `UInt` value.
    public var uintValue: UInt {
        checkExactInteger().uintValue
    }
}
