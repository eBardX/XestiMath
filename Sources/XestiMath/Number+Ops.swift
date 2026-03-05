// © 2025—2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Type Methods

    public static func & (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseAnd(with: n2.checkInteger())))
    }

    public static func &= (n1: inout Self,
                           n2: Self) {
        n1 = n1 & n2
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

    public static func / (z1: Self,
                          z2: Self) -> Self {
        switch (z1.value, z2.value) {
        case let (.complex(val1), .complex(val2)) where !val2.isZero:
            Self(.complex(val1.divided(by: val2)))

        case let (.complex(val1), .real(val2)) where !val2.isZero:
            Self(.complex(val1.divided(by: z2.toComplex())))

        case let (.real, .complex(val2)) where !val2.isZero:
            Self(.complex(z1.toComplex().divided(by: val2)))

        case let (.real(val1), .real(val2)) where !val2.isZero:
            Self(.real(val1.divided(by: val2)))

        default:
            fatalError("divisor must not be zero")
        }
    }

    public static func /= (z1: inout Self,
                           z2: Self) {
        z1 = z1 / z2
    }

    public static func | (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseOr(with: n2.checkInteger())))
    }

    public static func |= (n1: inout Self,
                           n2: Self) {
        n1 = n1 | n2
    }

    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        Self(.real(n1.checkInteger().bitwiseXor(with: n2.checkInteger())))
    }

    public static func ^= (n1: inout Self,
                           n2: Self) {
        n1 = n1 ^ n2
    }

    public static func << (n: Self,
                           k: Int) -> Self {
        Self(.real(n.checkInteger().bitwiseShiftLeft(bits: k)))
    }

    public static func <<= (n: inout Self,
                            k: Int) {
        n = n << k
    }

    public static func >> (n: Self,
                           k: Int) -> Self {
        Self(.real(n.checkInteger().bitwiseShiftRight(bits: k)))
    }

    public static func >>= (n: inout Self,
                            k: Int) {
        n = n >> k
    }

    public static prefix func ~ (n: Self) -> Self {
        Self(.real(n.checkInteger().bitwiseNot()))
    }
}
