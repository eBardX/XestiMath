// © 2024 John Gary Pusey (see LICENSE.md)

import Darwin
import Numerics

// swiftlint:disable file_length

extension Real: NumberOps {

    // MARK: Public Type Methods

    public static prefix func - (z: Self) -> Self {
        switch z {
        case let .exactInteger(val):
            return .exactInteger(-val)

        case let .floatingPoint(val):
            return .floatingPoint(-val)

        case let .fraction(val):
            return .fraction(-val)
        }
    }

    public static func - (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 - val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return .floatingPoint(val1 - val2)

        case let (.fraction(val1), .fraction(val2)):
            return .fraction(val1 - val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func * (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 * val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return .floatingPoint(val1 * val2)

        case let (.fraction(val1), .fraction(val2)):
            return .fraction(val1 * val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func / (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .fraction(Fraction(val1, val2))

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return .floatingPoint(val1 / val2)

        case let (.fraction(val1), .fraction(val2)):
            return .fraction(val1 / val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func & (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 & val2)

        case (.floatingPoint, .floatingPoint):
            return .floatingPoint((tmp1.exactIntegerValue &
                                   tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return .exactInteger(val1.numerator & val2.numerator)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func % (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 % val2)

        case (.floatingPoint, .floatingPoint):
            return .floatingPoint((tmp1.exactIntegerValue %
                                   tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return .exactInteger(val1.numerator % val2.numerator)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 ^ val2)

        case (.floatingPoint, .floatingPoint):
            return .floatingPoint((tmp1.exactIntegerValue ^
                                   tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return .exactInteger(val1.numerator ^ val2.numerator)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func + (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 + val2)

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return .floatingPoint(val1 + val2)

        case let (.fraction(val1), .fraction(val2)):
            return .fraction(val1 + val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func < (x1: Self,
                          x2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(x1, x2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return val1 < val2

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return val1 < val2

        case let (.fraction(val1), .fraction(val2)):
            return val1 < val2

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func << (n: Self,
                           k: Int) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp {
        case let .exactInteger(val):
            return .exactInteger(val << k)

        case .floatingPoint:
            return .floatingPoint((tmp.exactIntegerValue << k).doubleValue)

        case let .fraction(val):
            return .exactInteger(val.numerator << k)
        }
    }

    public static func == (z1: Self,
                           z2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return val1 == val2

        case let (.floatingPoint(val1), .floatingPoint(val2)):
            return val1 == val2

        case let (.fraction(val1), .fraction(val2)):
            return val1 == val2

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func >> (n: Self,
                           k: Int) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp {
        case let .exactInteger(val):
            return .exactInteger(val >> k)

        case .floatingPoint:
            return .floatingPoint((tmp.exactIntegerValue >> k).doubleValue)

        case let .fraction(val):
            return .exactInteger(val.numerator >> k)
        }
    }

    public static func | (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(Self.checkInteger(n1),
                                  Self.checkInteger(n2))

        switch (tmp1, tmp2) {
        case let (.exactInteger(val1), .exactInteger(val2)):
            return .exactInteger(val1 | val2)

        case (.floatingPoint, .floatingPoint):
            return .floatingPoint((tmp1.exactIntegerValue |
                                   tmp2.exactIntegerValue).doubleValue)

        case let (.fraction(val1), .fraction(val2)):
            return .exactInteger(val1.numerator | val2.numerator)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static prefix func ~ (n: Self) -> Self {
        let tmp = Self.checkInteger(n)

        switch tmp {
        case let .exactInteger(val):
            return .exactInteger(~val)

        case .floatingPoint:
            return .floatingPoint((~tmp.exactIntegerValue).doubleValue)

        case let .fraction(val):
            return .exactInteger(~val.numerator)
        }
    }

    // MARK: Public Instance Properties

    public var angle: Self {
        isNegative ? .inexactPi : isExact ? .exactZero : .inexactZero
    }

    public var denominator: Self {
        switch Self.checkRational(self) {
        case .exactInteger:
            return .exactOne

        case .floatingPoint:
            _ = Self.checkInteger(self)

            return .inexactOne

        case let .fraction(val):
            return .exactInteger(val.denominator)
        }
    }

    public var exactValue: Self {
        let tmp = Self.checkInteger(self)

        switch tmp {
        case .floatingPoint:
            return .exactInteger(tmp.exactIntegerValue)

        default:
            return self
        }
    }

    public var imaginary: Self {
        isExact ? .exactZero : .inexactZero
    }

    public var inexactValue: Self {
        switch self {
        case .floatingPoint:
            return self

        default:
            return .floatingPoint(doubleValue)
        }
    }

    public var isComplex: Bool {
        true
    }

    public var isEven: Bool {
        let tmp = Self.checkInteger(self)

        switch tmp {
        case let .exactInteger(val):
            return val.isEven

        case .floatingPoint:
            return tmp.exactIntegerValue.isEven

        case let .fraction(val):
            return val.exactIntegerValue.isEven
        }
    }

    public var isExact: Bool {
        switch self {
        case .floatingPoint:
            return false

        default:
            return true
        }
    }

    public var isFinite: Bool {
        switch self {
        case let .floatingPoint(val):
            return val.isFinite

        default:
            return true
        }
    }

    public var isInexact: Bool {
        switch self {
        case .floatingPoint:
            return true

        default:
            return false
        }
    }

    public var isInfinite: Bool {
        switch self {
        case let .floatingPoint(val):
            return val.isInfinite

        default:
            return false
        }
    }

    public var isInteger: Bool {
        switch self {
        case .exactInteger:
            return true

        case .floatingPoint:
            return isExactInteger

        case let .fraction(val):
            return val.isExactInteger
        }
    }

    public var isNaN: Bool {
        switch self {
        case let .floatingPoint(val):
            return val.isNaN

        default:
            return false
        }
    }

    public var isNegative: Bool {
        self < 0
    }

    public var isOdd: Bool {
        let tmp = Self.checkInteger(self)

        switch tmp {
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
        switch self {
        case let .floatingPoint(val):
            return val.isFinite

        default:
            return true
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
        switch Self.checkRational(self) {
        case .exactInteger:
            return self

        case .floatingPoint:
            return Self.checkInteger(self)

        case let .fraction(val):
            return .exactInteger(val.numerator)
        }
    }

    public var real: Self {
        self
    }

    // MARK: Private Type Properties

    private static let exactOne: Real = .exactInteger(1)
    private static let exactZero: Real = .exactInteger(0)
    private static let inexactOne: Real = .floatingPoint(1.0)
    private static let inexactPi: Real = .floatingPoint(.pi)
    private static let inexactZero: Real = .floatingPoint(0.0)
}

public func abs(_ x: Real) -> Real {
    x.isNegative ? -x : x
}

public func acos(_ z: Real) -> Real {
    .floatingPoint(.acos(z.doubleValue))
}

public func acosh(_ z: Real) -> Real {
    .floatingPoint(.acosh(z.doubleValue))
}

public func asin(_ z: Real) -> Real {
    .floatingPoint(.asin(z.doubleValue))
}

public func asinh(_ z: Real) -> Real {
    .floatingPoint(.asinh(z.doubleValue))
}

public func atan(_ z: Real) -> Real {
    .floatingPoint(.atan(z.doubleValue))
}

public func atan(_ y: Real,
                 _ x: Real) -> Real {
    .floatingPoint(.atan2(y: y.doubleValue,
                          x: x.doubleValue))
}

public func atanh(_ z: Real) -> Real {
    .floatingPoint(.atanh(z.doubleValue))
}

public func ceiling(_ x: Real) -> Real {
    switch x {
    case .exactInteger:
        return x

    case let .floatingPoint(val):
        return .floatingPoint(ceil(val))

    case let .fraction(val):
        return .exactInteger(val.ceiling())
    }
}

public func cos(_ z: Real) -> Real {
    .floatingPoint(.cos(z.doubleValue))
}

public func cosh(_ z: Real) -> Real {
    .floatingPoint(.cosh(z.doubleValue))
}

public func exp(_ z: Real) -> Real {
    .floatingPoint(.exp(z.doubleValue))
}

public func exp2(_ z: Real) -> Real {
    .floatingPoint(.exp2(z.doubleValue))
}

public func exp10(_ z: Real) -> Real {
    .floatingPoint(.exp10(z.doubleValue))
}

public func expb(_ z: Real,
                 _ base: Real) -> Real {
    .floatingPoint(.exp(z.doubleValue * .log(base.doubleValue)))
}

public func floor(_ x: Real) -> Real {
    switch x {
    case .exactInteger:
        return x

    case let .floatingPoint(val):
        return .floatingPoint(floor(val))

    case let .fraction(val):
        return .exactInteger(val.floor())
    }
}

public func gcd(_ n1: Real,
                _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1, tmp2) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return .exactInteger(gcd(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return .floatingPoint(gcd(tmp1.exactIntegerValue,
                                  tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return .exactInteger(gcd(val1.numerator,
                                 val2.numerator))

    default:
        fatalError("impossible case reached!")
    }
}

public func lcm(_ n1: Real,
                _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1, tmp2) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return .exactInteger(lcm(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return .floatingPoint(lcm(tmp1.exactIntegerValue,
                                  tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return .exactInteger(lcm(val1.numerator,
                                 val2.numerator))

    default:
        fatalError("impossible case reached!")
    }
}

public func log(_ z: Real) -> Real {
    .floatingPoint(.log(z.doubleValue))
}

public func log2(_ z: Real) -> Real {
    .floatingPoint(.log2(z.doubleValue))
}

public func log10(_ z: Real) -> Real {
    .floatingPoint(.log10(z.doubleValue))
}

public func logb(_ z: Real,
                 _ base: Real) -> Real {
    .floatingPoint(.log(z.doubleValue) / .log(base.doubleValue))
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

    switch (tmp1, tmp2) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return .exactInteger(modulo(val1, val2))

    case (.floatingPoint, .floatingPoint):
        return .floatingPoint(modulo(tmp1.exactIntegerValue,
                                     tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return .exactInteger(modulo(val1.numerator,
                                    val2.numerator))

    default:
        fatalError("impossible case reached!")
    }
}

public func power(_ z1: Real,
                  _ z2: Real) -> Real {
    .floatingPoint(.pow(z1.doubleValue,
                        z2.doubleValue))
}

public func quotient(_ n1: Real,
                     _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1, tmp2) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return .exactInteger(val1 / val2)

    case (.floatingPoint, .floatingPoint):
        return .floatingPoint((tmp1.exactIntegerValue /
                               tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return .exactInteger(val1.numerator / val2.numerator)

    default:
        fatalError("impossible case reached!")
    }
}

public func remainder(_ n1: Real,
                      _ n2: Real) -> Real {
    let (tmp1, tmp2) = Real.coerce(Real.checkInteger(n1),
                                   Real.checkInteger(n2))

    switch (tmp1, tmp2) {
    case let (.exactInteger(val1), .exactInteger(val2)):
        return .exactInteger(val1 % val2)

    case (.floatingPoint, .floatingPoint):
        return .floatingPoint((tmp1.exactIntegerValue %
                               tmp2.exactIntegerValue).doubleValue)

    case let (.fraction(val1), .fraction(val2)):
        return .exactInteger(val1.numerator % val2.numerator)

    default:
        fatalError("impossible case reached!")
    }
}

public func round(_ x: Real) -> Real {
    switch x {
    case .exactInteger:
        return x

    case let .floatingPoint(val):
        return .floatingPoint(round(val))

    case let .fraction(val):
        return .exactInteger(val.round())
    }
}

public func sin(_ z: Real) -> Real {
    .floatingPoint(.sin(z.doubleValue))
}

public func sinh(_ z: Real) -> Real {
    .floatingPoint(.sinh(z.doubleValue))
}

public func sqrt(_ z: Real) -> Real {
    .floatingPoint(.sqrt(z.doubleValue))
}

public func tan(_ z: Real) -> Real {
    .floatingPoint(.tan(z.doubleValue))
}

public func tanh(_ z: Real) -> Real {
    .floatingPoint(.tanh(z.doubleValue))
}

public func truncate(_ x: Real) -> Real {
    switch x {
    case .exactInteger:
        return x

    case let .floatingPoint(val):
        return .floatingPoint(trunc(val))

    case let .fraction(val):
        return .exactInteger(val.truncate())
    }
}
