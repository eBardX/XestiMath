// © 2025—2026 John Gary Pusey (see LICENSE.md)

// MARK: - Public Functions

public func abs(_ x: Number) -> Number {
    Number(.real(x.checkReal().absoluteValue()))
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
    Number(.real(y.checkReal().inverseTangent(x.checkReal())))
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
    Number(.real(x.checkReal().ceiling()))
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

public func exp(_ z: Number,
                base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.exponential(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.exponential(base: val2)))

    default:
        Number(.complex(z.toComplex().exponential(base: base.toComplex())))
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

public func floor(_ x: Number) -> Number {
    Number(.real(x.checkReal().floor()))
}

public func gcd(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().greatestCommonDivisor(with: n2.checkInteger())))
}

public func lcm(_ n1: Number,
                _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().leastCommonMultiple(with: n2.checkInteger())))
}

public func log(_ z: Number) -> Number {
    switch z.value {
    case let .complex(val):
        Number(.complex(val.logarithm()))

    case let .real(val):
        Number(.real(val.logarithm()))
    }
}

public func log(_ z: Number,
                base: Number) -> Number {
    switch (z.value, base.value) {
    case let (.complex(val1), .complex(val2)):
        Number(.complex(val1.logarithm(base: val2)))

    case let (.real(val1), .real(val2)):
        Number(.real(val1.logarithm(base: val2)))

    default:
        Number(.complex(z.toComplex().logarithm(base: base.toComplex())))
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
    Number(.real(n1.checkInteger().modulo(n2.checkInteger())))
}

public func quotient(_ n1: Number,
                     _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().quotient(dividingBy: n2.checkInteger())))
}

public func rationalize(_ x: Number,
                        _ y: Number) -> Number {
    guard let result = x.checkReal().rationalize(within: y.checkReal())
    else { fatalError("no rational representation of \(x) within \(y)") }

    return Number(.real(result))
}

public func remainder(_ n1: Number,
                      _ n2: Number) -> Number {
    Number(.real(n1.checkInteger().remainder(dividingBy: n2.checkInteger())))
}

public func round(_ x: Number) -> Number {
    Number(.real(x.checkReal().round()))
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
    Number(.real(x.checkReal().truncate()))
}
