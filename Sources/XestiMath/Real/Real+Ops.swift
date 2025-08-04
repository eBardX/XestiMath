// © 2024 John Gary Pusey (see LICENSE.md)

import Darwin
import RealModule

// swiftlint:disable file_length

extension Real: NumberOps {

    // MARK: Public Type Methods

    public static prefix func - (z: Self) -> Self {
        switch z.value {
        case let .exactInteger(val):
            Self(exactInteger: -val)

        case let .floatingPoint(val):
            Self(floatingPoint: -val)

        case let .fraction(val):
            Self(fraction: -val)
        }
    }

    public static func - (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 - val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return Self(floatingPoint: val1 - val2)

        case let (.fraction(val1), .fraction(val2)):
            return Self(fraction: val1 - val2)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func * (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 * val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return Self(floatingPoint: val1 * val2)

        case let (.fraction(val1), .fraction(val2)):
            return Self(fraction: val1 * val2)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func / (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(fraction: Fraction(val1, val2))

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return Self(floatingPoint: val1 / val2)

        case let (.fraction(val1), .fraction(val2)):
            return Self(fraction: val1 / val2)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func & (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 & val2)

        case (.floatingPoint, .floatingPoint):
            return Self(floatingPoint: (tmp1.exactIntegerValue &
                                        tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return Self(exactInteger: val1.numerator & val2.numerator)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func % (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 % val2)

        case (.floatingPoint, .floatingPoint):
            return Self(floatingPoint: (tmp1.exactIntegerValue %
                                        tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return Self(exactInteger: val1.numerator % val2.numerator)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 ^ val2)

        case (.floatingPoint, .floatingPoint):
            return Self(floatingPoint: (tmp1.exactIntegerValue ^
                                        tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return Self(exactInteger: val1.numerator ^ val2.numerator)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func + (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 + val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return Self(floatingPoint: val1 + val2)

        case let (.fraction(val1), .fraction(val2)):
            return Self(fraction: val1 + val2)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func < (x1: Self,
                          x2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(x1, x2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return val1 < val2

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return val1 < val2

        case let (.fraction(val1), .fraction(val2)):
            return val1 < val2

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func << (n: Self,
                           k: Int) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp.value {
        case let .exactInteger(val):
            return Self(exactInteger: val << k)

        case .floatingPoint:
            return Self(floatingPoint: (tmp.exactIntegerValue << k).doubleValue)

        case let .fraction(val):
            return Self(exactInteger: val.numerator << k)
        }
    }

    public static func == (z1: Self,
                           z2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return val1 == val2

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return val1 == val2

        case let (.fraction(val1), .fraction(val2)):
            return val1 == val2

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static func >> (n: Self,
                           k: Int) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp.value {
        case let .exactInteger(val):
            return Self(exactInteger: val >> k)

        case .floatingPoint:
            return Self(floatingPoint: (tmp.exactIntegerValue >> k).doubleValue)

        case let .fraction(val):
            return Self(exactInteger: val.numerator >> k)
        }
    }

    public static func | (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1.value, tmp2.value) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return Self(exactInteger: val1 | val2)

        case (.floatingPoint, .floatingPoint):
            return Self(floatingPoint: (tmp1.exactIntegerValue |
                                        tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return Self(exactInteger: val1.numerator | val2.numerator)

        default:
            fatalError("Impossible case reached!")
        }
    }

    public static prefix func ~ (n: Self) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp.value {
        case let .exactInteger(val):
            return Self(exactInteger: ~val)

        case .floatingPoint:
            return Self(floatingPoint: (~tmp.exactIntegerValue).doubleValue)

        case let .fraction(val):
            return Self(exactInteger: ~val.numerator)
        }
    }

    // MARK: Public Instance Properties

    public var angle: Self {
        isNegative ? .inexactPi : isExact ? .exactZero : .inexactZero
    }

    public var denominator: Self {
        switch Self.checkRational(self).value {
        case .exactInteger:
            return .exactOne

        case .floatingPoint:
            _ = Self.checkInteger(self)

            return .inexactOne

        case let .fraction(val):
            return Self(exactInteger: val.denominator)
        }
    }

    public var exactValue: Self {
        let tmp = Self.checkInteger(self)

        switch tmp.value {
        case .floatingPoint:
            return Self(exactInteger: tmp.exactIntegerValue)

        default:
            return self
        }
    }

    public var imaginary: Self {
        isExact ? .exactZero : .inexactZero
    }

    public var inexactValue: Self {
        switch value {
        case .floatingPoint:
            self

        default:
            Self(floatingPoint: doubleValue)
        }
    }

    public var isComplex: Bool {
        true
    }

    public var isEven: Bool {
        let tmp = Self.checkInteger(self)

        switch tmp.value {
        case let .exactInteger(val):
            return val.isEven

        case .floatingPoint:
            return tmp.exactIntegerValue.isEven

        case let .fraction(val):
            return val.exactIntegerValue.isEven
        }
    }

    public var isExact: Bool {
        switch value {
        case .floatingPoint:
            false

        default:
            true
        }
    }

    public var isFinite: Bool {
        switch value {
        case let .floatingPoint(val):
            val.isFinite

        default:
            true
        }
    }

    public var isInexact: Bool {
        switch value {
        case .floatingPoint:
            true

        default:
            false
        }
    }

    public var isInfinite: Bool {
        switch value {
        case let .floatingPoint(val):
            val.isInfinite

        default:
            false
        }
    }

    public var isInteger: Bool {
        switch value {
        case .exactInteger:
            true

        case let .floatingPoint(val):
            Double(Int(val)) == val

        case let .fraction(val):
            val.isExactInteger
        }
    }

    public var isNaN: Bool {
        switch value {
        case let .floatingPoint(val):
            val.isNaN

        default:
            false
        }
    }

    public var isNegative: Bool {
        self < 0
    }

    public var isOdd: Bool {
        let tmp = Self.checkInteger(self)

        switch tmp.value {
        case let .exactInteger(val):
            return val.isOdd

        case .floatingPoint:
            return tmp.exactIntegerValue.isOdd

        case let .fraction(val):
            return val.exactIntegerValue.isOdd
        }
    }

    public var isPositive: Bool {
        self > 0
    }

    public var isRational: Bool {
        switch value {
        case let .floatingPoint(val):
            val.isFinite

        default:
            true
        }
    }

    public var isReal: Bool {
        true
    }

    public var isZero: Bool {
        self == 0
    }

    public var magnitude: Self {
        abs(self)
    }

    public var numerator: Self {
        switch Self.checkRational(self).value {
        case .exactInteger:
            self

        case .floatingPoint:
            Self.checkInteger(self)

        case let .fraction(val):
            Self(exactInteger: val.numerator)
        }
    }

    public var real: Self {
        self
    }

    public var simplified: Self {
        switch value {
        case let .fraction(val):
            val.isExactInteger ? Self(exactInteger: val.numerator) : self

        default:
            self
        }
    }

    // MARK: Private Type Properties

    private static let exactOne = Self(exactInteger: 1)
    private static let exactZero = Self(exactInteger: 0)
    private static let inexactOne = Self(floatingPoint: 1.0)
    private static let inexactPi = Self(floatingPoint: .pi)
    private static let inexactZero = Self(floatingPoint: 0.0)
}

public func abs(_ x: Real) -> Real {
    x.isNegative ? -x : x
}

public func acos(_ z: Real) -> Real {
    Real(floatingPoint: .acos(z.doubleValue))
}

public func acosh(_ z: Real) -> Real {
    Real(floatingPoint: .acosh(z.doubleValue))
}

public func asin(_ z: Real) -> Real {
    Real(floatingPoint: .asin(z.doubleValue))
}

public func asinh(_ z: Real) -> Real {
    Real(floatingPoint: .asinh(z.doubleValue))
}

public func atan(_ z: Real) -> Real {
    Real(floatingPoint: .atan(z.doubleValue))
}

public func atan(_ y: Real,
                 _ x: Real) -> Real {
    Real(floatingPoint: .atan2(y: y.doubleValue,
                               x: x.doubleValue))
}

public func atanh(_ z: Real) -> Real {
    Real(floatingPoint: .atanh(z.doubleValue))
}

public func ceiling(_ x: Real) -> Real {
    switch x.value {
    case .exactInteger:
        x

    case let .floatingPoint(val):
        Real(floatingPoint: ceil(val))

    case let .fraction(val):
        Real(exactInteger: val.ceiling())
    }
}

public func cos(_ z: Real) -> Real {
    Real(floatingPoint: .cos(z.doubleValue))
}

public func cosh(_ z: Real) -> Real {
    Real(floatingPoint: .cosh(z.doubleValue))
}

public func exp(_ z: Real) -> Real {
    Real(floatingPoint: .exp(z.doubleValue))
}

public func exp2(_ z: Real) -> Real {
    Real(floatingPoint: .exp2(z.doubleValue))
}

public func exp10(_ z: Real) -> Real {
    Real(floatingPoint: .exp10(z.doubleValue))
}

public func expb(_ z: Real,
                 _ base: Real) -> Real {
    Real(floatingPoint: .exp(z.doubleValue * .log(base.doubleValue)))
}

public func floor(_ x: Real) -> Real {
    switch x.value {
    case .exactInteger:
        x

    case let .floatingPoint(val):
        Real(floatingPoint: floor(val))

    case let .fraction(val):
        Real(exactInteger: val.floor())
    }
}

public func gcd(_ n1: Real,
                _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1.value, tmp2.value) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return Real(exactInteger: gcd(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return Real(floatingPoint: gcd(tmp1.exactIntegerValue,
                                       tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return Real(exactInteger: gcd(val1.numerator,
                                      val2.numerator))

    default:
        fatalError("Impossible case reached!")
    }
}

public func lcm(_ n1: Real,
                _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1.value, tmp2.value) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return Real(exactInteger: lcm(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return Real(floatingPoint: lcm(tmp1.exactIntegerValue,
                                       tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return Real(exactInteger: lcm(val1.numerator,
                                      val2.numerator))

    default:
        fatalError("Impossible case reached!")
    }
}

public func log(_ z: Real) -> Real {
    Real(floatingPoint: .log(z.doubleValue))
}

public func log2(_ z: Real) -> Real {
    Real(floatingPoint: .log2(z.doubleValue))
}

public func log10(_ z: Real) -> Real {
    Real(floatingPoint: .log10(z.doubleValue))
}

public func logb(_ z: Real,
                 _ base: Real) -> Real {
    Real(floatingPoint: .log(z.doubleValue) / .log(base.doubleValue))
}

public func max(_ x1: Real,
                _ x2: Real) -> Real {
    x1 < x2 ? x2 : x1
}

public func min(_ x1: Real,
                _ x2: Real) -> Real {
    x1 > x2 ? x2 : x1
}

public func modulo(_ n1: Real,
                   _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1.value, tmp2.value) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return Real(exactInteger: modulo(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return Real(floatingPoint: modulo(tmp1.exactIntegerValue,
                                          tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return Real(exactInteger: modulo(val1.numerator,
                                         val2.numerator))

    default:
        fatalError("Impossible case reached!")
    }
}

public func power(_ z1: Real,
                  _ z2: Real) -> Real {
    Real(floatingPoint: .pow(z1.doubleValue,
                             z2.doubleValue))
}

public func quotient(_ n1: Real,
                     _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1.value, tmp2.value) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return Real(exactInteger: val1 / val2)

    case (.floatingPoint, .floatingPoint):
        return Real(floatingPoint: (tmp1.exactIntegerValue /
                                    tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return Real(exactInteger: val1.numerator / val2.numerator)

    default:
        fatalError("Impossible case reached!")
    }
}

public func remainder(_ n1: Real,
                      _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1.value, tmp2.value) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return Real(exactInteger: val1 % val2)

    case (.floatingPoint, .floatingPoint):
        return Real(floatingPoint: (tmp1.exactIntegerValue %
                                    tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return Real(exactInteger: val1.numerator % val2.numerator)

    default:
        fatalError("Impossible case reached!")
    }
}

public func round(_ x: Real) -> Real {
    switch x.value {
    case .exactInteger:
        x

    case let .floatingPoint(val):
        Real(floatingPoint: round(val))

    case let .fraction(val):
        Real(exactInteger: val.round())
    }
}

public func sin(_ z: Real) -> Real {
    Real(floatingPoint: .sin(z.doubleValue))
}

public func sinh(_ z: Real) -> Real {
    Real(floatingPoint: .sinh(z.doubleValue))
}

public func sqrt(_ z: Real) -> Real {
    Real(floatingPoint: .sqrt(z.doubleValue))
}

public func tan(_ z: Real) -> Real {
    Real(floatingPoint: .tan(z.doubleValue))
}

public func tanh(_ z: Real) -> Real {
    Real(floatingPoint: .tanh(z.doubleValue))
}

public func truncate(_ x: Real) -> Real {
    switch x.value {
    case .exactInteger:
        x

    case let .floatingPoint(val):
        Real(floatingPoint: trunc(val))

    case let .fraction(val):
        Real(exactInteger: val.truncate())
    }
}
