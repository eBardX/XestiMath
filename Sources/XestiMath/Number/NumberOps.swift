// © 2024 John Gary Pusey (see LICENSE.md)

public protocol NumberOps: Comparable {
    static prefix func - (z: Self) -> Self                  // negate

    static func - (z1: Self,
                   z2: Self) -> Self

    static func -= (z1: inout Self,
                    z2: Self)

    static func * (z1: Self,
                   z2: Self) -> Self

    static func *= (z1: inout Self,
                    z2: Self)

    static func / (z1: Self,
                   z2: Self) -> Self

    static func /= (z1: inout Self,
                    z2: Self)

    static func & (n1: Self,
                   n2: Self) -> Self

    static func &= (n1: inout Self,
                    n2: Self)

    static func % (n1: Self,
                   n2: Self) -> Self

    static func %= (n1: inout Self,
                    n2: Self)

    static func ^ (n1: Self,
                   n2: Self) -> Self

    static func ^= (n1: inout Self,
                    n2: Self)

    static func + (z1: Self,
                   z2: Self) -> Self

    static func += (z1: inout Self,
                    z2: Self)

    static func < (x1: Self,
                   x2: Self) -> Bool

    static func << (n: Self,
                    k: Int) -> Self

    static func <<= (n: inout Self,
                     k: Int)

    static func >> (n: Self,
                    k: Int) -> Self

    static func >>= (n: inout Self,
                     k: Int)

    static func | (n1: Self,
                   n2: Self) -> Self

    static func |= (n1: inout Self,
                    n2: Self)

    static prefix func ~ (n: Self) -> Self                  // integer n

    var angle: Self { get }
    var denominator: Self { get }                           // rational self
    var exactValue: Self { get }
    var imaginary: Self { get }
    var inexactValue: Self { get }
    var isComplex: Bool { get }
    var isEven: Bool { get }                                // integer self
    var isExact: Bool { get }
    var isFinite: Bool { get }
    var isInexact: Bool { get }
    var isInfinite: Bool { get }
    var isInteger: Bool { get }
    var isNaN: Bool { get }
    var isNegative: Bool { get }                            // real self
    var isOdd: Bool { get }                                 // integer self
    var isPositive: Bool { get }                            // real self
    var isRational: Bool { get }
    var isReal: Bool { get }
    var isZero: Bool { get }
    var magnitude: Self { get }
    var numerator: Self { get }
    var real: Self { get }
}

extension NumberOps {
    public static func -= (z1: inout Self,
                           z2: Self) {
        z1 = z1 - z2
    }

    public static func *= (z1: inout Self,
                           z2: Self) {
        z1 = z1 * z2
    }

    public static func /= (z1: inout Self,
                           z2: Self) {
        z1 = z1 / z2
    }

    public static func &= (n1: inout Self,
                           n2: Self) {
        n1 = n1 & n2
    }

    public static func %= (n1: inout Self,
                           n2: Self) {
        n1 = n1 % n2
    }

    public static func ^= (n1: inout Self,
                           n2: Self) {
        n1 = n1 ^ n2
    }

    public static func += (z1: inout Self,
                           z2: Self) {
        z1 = z1 + z2
    }

    public static func <<= (n: inout Self,
                            k: Int) {
        n = n << k
    }

    public static func >>= (n: inout Self,
                            k: Int) {
        n = n >> k
    }

    public static func |= (n1: inout Self,
                           n2: Self) {
        n1 = n1 | n2
    }
}
