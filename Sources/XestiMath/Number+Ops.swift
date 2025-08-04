// © 2025 John Gary Pusey (see LICENSE.md)

// swiftlint:disable file_length

extension Number {

    // MARK: Public Type Methods

    public static prefix func - (z: Self) -> Self {
        switch z.value {
        case let .complex(val):
            Self(.complex(val.negated()))

        case let .real(val):
            Self(.real(val.negated()))
        }
    }

    public static func - (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.subtracting(val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.subtracting(val2)))

        default:
            Self(.complex(z1.toComplex().subtracting(z2.toComplex())))
        }
    }

    public static func -= (z1: inout Self,
                           z2: Self) {
        z1 = z1 - z2
    }

    public static func * (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.multiplied(by: val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.multiplied(by: val2)))

        default:
            Self(.complex(z1.toComplex().multiplied(by: z2.toComplex())))
        }
    }

    public static func *= (z1: inout Self,
                           z2: Self) {
        z1 = z1 * z2
    }

    public static func / (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.divided(by: val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.divided(by: val2)))

        default:
            Self(.complex(z1.toComplex().divided(by: z2.toComplex())))
        }
    }

    public static func /= (z1: inout Self,
                           z2: Self) {
        z1 = z1 / z2
    }

    public static func & (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.toInteger().bitwiseAnd(with: n2.toInteger())))
    }

    public static func &= (n1: inout Self,
                           n2: Self) {
        n1 = n1 & n2
    }

    public static func % (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.toInteger().remainder(dividingBy: n2.toInteger())))
    }

    public static func %= (n1: inout Self,
                           n2: Self) {
        n1 = n1 % n2
    }

    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.toInteger().bitwiseXor(with: n2.toInteger())))
    }

    public static func ^= (n1: inout Self,
                           n2: Self) {
        n1 = n1 ^ n2
    }

    public static func + (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            Self(.complex(val1.adding(val2)))

        case let (.real(val1), .real(val2)):
            Self(.real(val1.adding(val2)))

        default:
            Self(.complex(z1.toComplex().adding(z2.toComplex())))
        }
    }

    public static func += (z1: inout Self,
                           z2: Self) {
        z1 = z1 + z2
    }

    public static func < (x1: Self,
                          x2: Self) -> Bool {
        x1.toReal().isLess(than: x2.toReal())
    }

    public static func << (n: Self,
                           k: Int) -> Self {
        Self(.real(n.toInteger().bitwiseShiftLeft(bits: k)))
    }

    public static func <<= (n: inout Self,
                            k: Int) {
        n = n << k
    }

    public static func == (z1: Self,
                           z2: Self) -> Bool {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)):
            val1.isEqual(to: val2)

        case let (.real(val1), .real(val2)):
            val1.isEqual(to: val2)

        default:
            z1.toComplex().isEqual(to: z2.toComplex())
        }
    }

    public static func >> (n: Self,
                           k: Int) -> Self {
        Self(.real(n.toInteger().bitwiseShiftRight(bits: k)))
    }

    public static func >>= (n: inout Self,
                            k: Int) {
        n = n >> k
    }

    public static func | (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.toInteger().bitwiseOr(with: n2.toInteger())))
    }

    public static func |= (n1: inout Self,
                           n2: Self) {
        n1 = n1 | n2
    }

    public static prefix func ~ (n: Self) -> Self {
        Self(.real(n.toInteger().bitwiseNot()))
    }

    // MARK: Public Instance Properties

    public var angle: Self {        // z
        switch value {
        case let .complex(val):
            Self(.real(val.angle))

        case let .real(val):
            Self(.real(val.angle))
        }
    }

    public var denominator: Self {  // q
        Self(.real(toRational().denominator))
    }

    public var exact: Self {        // z
        switch value {
        case let .complex(val):
            val.isInexact ? Self(.complex(val.exact)) : self

        case let .real(val):
            val.isInexact ? Self(.real(val.exact)) : self
        }
    }

    public var imaginary: Self {    // z
        switch value {
        case let .complex(val):
            Self(.real(val.imaginary))

        case let .real(val):
            Self(.real(val.isExact ? .exactZero : .inexactZero))
        }
    }

    public var inexact: Self {      // z
        switch value {
        case let .complex(val):
            val.isExact ? Self(.complex(val.inexact)) : self

        case let .real(val):
            val.isExact ? Self(.real(val.inexact)) : self
        }
    }

    public var isComplex: Bool {    // z
        true
    }

    public var isEven: Bool {       // n
        toInteger().isEven
    }

    public var isExact: Bool {      // z
        switch value {
        case let .complex(val):
            val.isExact

        case let .real(val):
            val.isExact
        }
    }

    public var isFinite: Bool {     // z
        switch value {
        case let .complex(val):
            val.isFinite

        case let .real(val):
            val.isFinite
        }
    }

    public var isInexact: Bool {    // z
        switch value {
        case let .complex(val):
            val.isInexact

        case let .real(val):
            val.isInexact
        }
    }

    public var isInfinite: Bool {   // z
        switch value {
        case let .complex(val):
            val.isInfinite

        case let .real(val):
            val.isInfinite
        }
    }

    public var isInteger: Bool {    // z
        switch value {
        case let .complex(val):
            val.isInteger

        case let .real(val):
            val.isInteger
        }
    }

    public var isNaN: Bool {        // z
        switch value {
        case let .complex(val):
            val.isNaN

        case let .real(val):
            val.isNaN
        }
    }

    public var isNegative: Bool {   // x
        toReal().isNegative
    }

    public var isOdd: Bool {        // n
        toInteger().isOdd
    }

    public var isPositive: Bool {   // x
        toReal().isPositive
    }

    public var isRational: Bool {   // z
        switch value {
        case let .complex(val):
            val.isRational

        case let .real(val):
            val.isRational
        }
    }

    public var isReal: Bool {       // z
        switch value {
        case let .complex(val):
            val.isReal

        case .real:
            true
        }
    }

    public var isZero: Bool {       // z
        switch value {
        case let .complex(val):
            val.isZero

        case let .real(val):
            val.isZero
        }
    }

    public var magnitude: Self {    // z
        switch value {
        case let .complex(val):
            Self(.real(val.magnitude))

        case let .real(val):
            Self(.real(val.absoluteValue()))
        }
    }

    public var numerator: Self {    // q
        Self(.real(toRational().numerator))
    }

    public var real: Self {         // z
        switch value {
        case let .complex(val):
            Self(.real(val.real))

        case .real:
            self
        }
    }

    public var simplified: Self {   // z
        switch value {
        case let .complex(val):
            if val.isReal {
                Self(.real(val.real.simplified))
            } else {
                Self(.complex(Complex(real: val.real.simplified,
                                      imaginary: val.imaginary.simplified)))
            }

        case let .real(val):
            Self(.real(val.simplified))
        }
    }

    // MARK: Internal Instance Methods

    internal func toComplex() -> Complex {
        switch value {
        case let .complex(val):
            val

        case let .real(val):
            Complex(real: val,
                    imaginary: val.isExact ? .exactZero : .inexactZero)
        }
    }

    internal func toExactInteger() -> ExactInteger {
        switch value {
        case let .complex(val) where val.isExact && val.isInteger:
            val.real.exactIntegerValue

        case let .real(val) where val.isExact && val.isInteger:
            val.exactIntegerValue

        default:
            fatalError("\(self) is not an exact integer")
        }
    }

    internal func toInteger() -> Real {
        switch value {
        case let .complex(val) where val.isInteger:
            val.real

        case let .real(val) where val.isInteger:
            val

        default:
            fatalError("\(self) is not an integer")
        }
    }

    internal func toRational() -> Real {
        switch value {
        case let .complex(val) where val.isRational:
            val.real

        case let .real(val) where val.isRational:
            val

        default:
            fatalError("\(self) is not a rational number")
        }
    }

    internal func toReal() -> Real {
        switch value {
        case let .complex(val) where val.isReal:
            val.real

        case let .real(val):
            val

        default:
            fatalError("\(self) is not a real number")
        }
    }
}

public func abs(_ x: Number) -> Number {
    Number(.real(x.toReal().absoluteValue()))
}

public func acos(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseCosine()))

    case let .real(val):
        Number(.real(val.inverseCosine()))
    }
}

public func acosh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyperbolicCosine()))

    case let .real(val):
        Number(.real(val.inverseHyperbolicCosine()))
    }
}

public func asin(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseSine()))

    case let .real(val):
        Number(.real(val.inverseSine()))
    }
}

public func asinh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyperbolicSine()))

    case let .real(val):
        Number(.real(val.inverseHyperbolicSine()))
    }
}

public func atan(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseTangent()))

    case let .real(val):
        Number(.real(val.inverseTangent()))
    }
}

public func atan(_ y: Number,
                 _ x: Number) -> Number {
    Number(.real(y.toReal().inverseTangent(x.toReal())))
}

public func atanh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.inverseHyberbolicTangent()))

    case let .real(val):
        Number(.real(val.inverseHyberbolicTangent()))
    }
}

public func ceiling(_ x: Number) -> Number {
    Number(.real(x.toReal().ceiling()))
}

public func cos(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.cosine()))

    case let .real(val):
        Number(.real(val.cosine()))
    }
}

public func cosh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicCosine()))

    case let .real(val):
        Number(.real(val.hyperbolicCosine()))
    }
}

public func exp(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponential()))

    case let .real(val):
        Number(.real(val.exponential()))
    }
}

public func exp10(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponentialBase10()))

    case let .real(val):
        Number(.real(val.exponentialBase10()))
    }
}

public func exp2(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.exponentialBase2()))

    case let .real(val):
        Number(.real(val.exponentialBase2()))
    }
}

public func expb(_ z: Number,
                 _ base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.exponential(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.exponential(base: val2)))

    default:
        Number(.complex(z.toComplex().exponential(base: base.toComplex())))
    }
}

public func floor(_ x: Number) -> Number {
    Number(.real(x.toReal().floor()))
}

public func gcd(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.toInteger().greatestCommonDivisor(with: n2.toInteger())))
}

public func lcm(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.toInteger().leastCommonMultiple(with: n2.toInteger())))
}

public func log(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithm()))

    case let .real(val):
        Number(.real(val.logarithm()))
    }
}

public func log10(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithmBase10()))

    case let .real(val):
        Number(.real(val.logarithmBase10()))
    }
}

public func log2(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithmBase2()))

    case let .real(val):
        Number(.real(val.logarithmBase2()))
    }
}

public func logb(_ z: Number,
                 _ base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.logarithm(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.logarithm(base: val2)))

    default:
        Number(.complex(z.toComplex().logarithm(base: base.toComplex())))
    }
}

public func max(_ x1: Number,
                _ x2: Number) -> Number {
    x1 < x2 ? x2 : x1
}

public func min(_ x1: Number,
                _ x2: Number) -> Number {
    x1 > x2 ? x2 : x1
}

public func modulo(_ n1: Number,
                   _ n2: Number) -> Number {
    Number(.real(n1.toInteger().modulo(n2.toInteger())))
}

public func power(_ z1: Number,
                  _ z2: Number) -> Number {
    switch (z1.value, z2.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.power(val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.power(val2)))

    default:
        Number(.complex(z1.toComplex().power(z2.toComplex())))
    }
}

public func quotient(_ n1: Number,
                     _ n2: Number) -> Number {
    Number(.real(n1.toInteger().quotient(dividingBy: n2.toInteger())))
}

public func remainder(_ n1: Number,
                      _ n2: Number) -> Number {
    Number(.real(n1.toInteger().remainder(dividingBy: n2.toInteger())))
}

public func round(_ x: Number) -> Number {
    Number(.real(x.toReal().round()))
}

public func sin(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.sine()))

    case let .real(val):
        Number(.real(val.sine()))
    }
}

public func sinh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicSine()))

    case let .real(val):
        Number(.real(val.hyperbolicSine()))
    }
}

public func sqrt(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.squareRoot()))

    case let .real(val):
        if val.isNegative {
            Number(.complex(z.toComplex().squareRoot()))
        } else {
            Number(.real(val.squareRoot()))
        }
    }
}

public func tan(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.tangent()))

    case let .real(val):
        Number(.real(val.tangent()))
    }
}

public func tanh(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.hyperbolicTangent()))

    case let .real(val):
        Number(.real(val.hyperbolicTangent()))
    }
}

public func truncate(_ x: Number) -> Number {
    Number(.real(x.toReal().truncate()))
}
