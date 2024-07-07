// © 2024 John Gary Pusey (see LICENSE.md)

import BigInt

extension ExactInteger {

    // MARK: Public Type Methods

    public static prefix func - (z: Self) -> Self {
        switch z {
        case let .large(val):
            return .large(-val)

        case let .small(val):
            let result = 0.subtractingReportingOverflow(val)

            if result.overflow {
                return .large(-BigInt(val))
            }

            return .small(result.partialValue)
        }
    }

    public static func - (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 - val2)

        case let (.small(val1), .small(val2)):
            let result = val1.subtractingReportingOverflow(val2)

            if result.overflow {
                return .large(BigInt(val1) - BigInt(val2))
            }

            return .small(result.partialValue)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func * (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 * val2)

        case let (.small(val1), .small(val2)):
            let result = val1.multipliedReportingOverflow(by: val2)

            if result.overflow {
                return .large(BigInt(val1) * BigInt(val2))
            }

            return .small(result.partialValue)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func / (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 / val2)

        case let (.small(val1), .small(val2)):
            let result = val1.dividedReportingOverflow(by: val2)

            if result.overflow {
                return .large(BigInt(val1) / BigInt(val2))
            }

            return .small(result.partialValue)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func /= (z1: inout Self,
                           z2: Self) {
        z1 = z1 / z2
    }

    public static func & (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(n1, n2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 & val2)

        case let (.small(val1), .small(val2)):
            return .small(val1 & val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func % (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(n1, n2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 % val2)

        case let (.small(val1), .small(val2)):
            return .small(val1 % val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func ^ (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(n1, n2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 ^ val2)

        case let (.small(val1), .small(val2)):
            return .small(val1 ^ val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func + (z1: Self,
                          z2: Self) -> Self {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 + val2)

        case let (.small(val1), .small(val2)):
            let result = val1.addingReportingOverflow(val2)

            if result.overflow {
                return .large(BigInt(val1) + BigInt(val2))
            }

            return .small(result.partialValue)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func < (x1: Self,
                          x2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(x1, x2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return val1 < val2

        case let (.small(val1), .small(val2)):
            return val1 < val2

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func << (n: Self,
                           k: Int) -> Self {
        switch n {
        case let .large(val):
            return .large(val << k)

        case let .small(val):
            if k > 0 {
                return .large(BigInt(val) << k)
            }

            return .small(val << k) // cannot overflow
        }
    }

    public static func == (z1: Self,
                           z2: Self) -> Bool {
        let (tmp1, tmp2) = coerce(z1, z2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return val1 == val2

        case let (.small(val1), .small(val2)):
            return val1 == val2

        default:
            fatalError("impossible case reached!")
        }
    }

    public static func >> (n: Self,
                           k: Int) -> Self {
        switch n {
        case let .large(val):
            return .large(val >> k)

        case let .small(val):
            if k < 0 {
                return .large(BigInt(val) >> k)
            }

            return .small(val >> k) // cannot overflow
        }
    }

    public static func | (n1: Self,
                          n2: Self) -> Self {
        let (tmp1, tmp2) = coerce(n1, n2)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return .large(val1 | val2)

        case let (.small(val1), .small(val2)):
            return .small(val1 | val2)

        default:
            fatalError("impossible case reached!")
        }
    }

    public static prefix func ~ (n: Self) -> Self {
        switch n {
        case let .large(val):
            return .large(~val)

        case let .small(val):
            return .small(~val)
        }
    }

    // MARK: Public Instance Properties

    public var isEven: Bool {
        switch self {
        case let .large(val):
            return (val & 1) == 0

        case let .small(val):
            return (val & 1) == 0
        }
    }

    public var isOdd: Bool {
        switch self {
        case let .large(val):
            return (val & 1) != 0

        case let .small(val):
            return (val & 1) != 0
        }
    }

    // MARK: Public Instance Methods

    public func isMultiple(of n: ExactInteger) -> Bool {
        let (tmp1, tmp2) = ExactInteger.coerce(self, n)

        switch (tmp1, tmp2) {
        case let (.large(val1), .large(val2)):
            return val1.isMultiple(of: val2)

        case let (.small(val1), .small(val2)):
            return val1.isMultiple(of: val2)

        default:
            fatalError("impossible case reached!")
        }
    }
}

public func abs(_ x: ExactInteger) -> ExactInteger {
    x < 0 ? -x : x
}

public func gcd(_ n1: ExactInteger,
                _ n2: ExactInteger) -> ExactInteger {
    let (tmp1, tmp2) = ExactInteger.coerce(abs(n1), abs(n2))

    switch (tmp1, tmp2) {
    case let (.large(val1), .large(val2)):
        return (.large(val1.greatestCommonDivisor(with: val2)))

    case let (.small(val1), .small(val2)):
        return .small(Int(UInt.gcd(UInt(val1), UInt(val2))))

    default:
        fatalError("impossible case reached!")
    }
}

public func lcm(_ n1: ExactInteger,
                _ n2: ExactInteger) -> ExactInteger {
    let n1 = abs(n1)
    let n2 = abs(n2)

    return quotient(n1, gcd(n1, n2)) * n2
}

public func max(_ x1: ExactInteger,
                _ x2: ExactInteger) -> ExactInteger {
    x1 < x2 ? x2 : x1
}

public func min(_ x1: ExactInteger,
                _ x2: ExactInteger) -> ExactInteger {
    x1 > x2 ? x2 : x1
}

public func modulo(_ n1: ExactInteger,
                   _ n2: ExactInteger) -> ExactInteger {
    let (tmp1, tmp2) = ExactInteger.coerce(n1, n2)

    switch (tmp1, tmp2) {
    case let (.large(val1), .large(val2)):
        return .large(val1.modulus(val2))

    case let (.small(val1), .small(val2)):
        return .small(Int.modulo(val1, val2))

    default:
        fatalError("impossible case reached!")
    }
}

public func quotient(_ n1: ExactInteger,
                     _ n2: ExactInteger) -> ExactInteger {
    let (tmp1, tmp2) = ExactInteger.coerce(n1, n2)

    switch (tmp1, tmp2) {
    case let (.large(val1), .large(val2)):
        return .large(val1 / val2)

    case let (.small(val1), .small(val2)):
        return .small(val1 / val2)

    default:
        fatalError("impossible case reached!")
    }
}

public func quotientAndRemainder(_ n1: ExactInteger,
                                 _ n2: ExactInteger) -> (quotient: ExactInteger,
                                                         remainder: ExactInteger) {
    let (tmp1, tmp2) = ExactInteger.coerce(n1, n2)

    switch (tmp1, tmp2) {
    case let (.large(val1), .large(val2)):
        let (quo, rem) = val1.quotientAndRemainder(dividingBy: val2)

        return (.large(quo), .large(rem))

    case let (.small(val1), .small(val2)):
        let (quo, rem) = val1.quotientAndRemainder(dividingBy: val2)

        return (.small(quo), .small(rem))

    default:
        fatalError("impossible case reached!")
    }
}

public func remainder(_ n1: ExactInteger,
                      _ n2: ExactInteger) -> ExactInteger {
    let (tmp1, tmp2) = ExactInteger.coerce(n1, n2)

    switch (tmp1, tmp2) {
    case let (.large(val1), .large(val2)):
        return .large(val1 % val2)

    case let (.small(val1), .small(val2)):
        return .small(val1 % val2)

    default:
        fatalError("impossible case reached!")
    }
}

public func sqrt(_ z: ExactInteger) -> ExactInteger {
    switch z {
    case let .large(val):
        return .large(val.squareRoot())

    case let .small(val):
        return .large(BigInt(val).squareRoot())
    }
}
