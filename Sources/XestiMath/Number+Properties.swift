// © 2025—2026 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Instance Properties

    public var angle: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.angle))

        case let .real(val):
            Self(.real(val.angle))
        }
    }

    public var denominator: Self {
        Self(.real(checkRational().denominator))
    }

    public var exact: Self {
        switch value {
        case let .complex(val) where val.isFinite:
            val.isInexact ? Self(.complex(val.exact)) : self

        case let .real(val) where val.isFinite:
            val.isInexact ? Self(.real(val.exact)) : self

        default:
            fatalError("No exact representation of \(self)")
        }
    }

    public var imaginaryPart: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.imaginaryPart))

        case let .real(val):
            Self(.real(val.isExact ? .exactZero : .inexactZero))
        }
    }

    public var inexact: Self {
        switch value {
        case let .complex(val):
            val.isExact ? Self(.complex(val.inexact)) : self

        case let .real(val):
            val.isExact ? Self(.real(val.inexact)) : self
        }
    }

    public var isComplex: Bool {
        true
    }

    public var isEven: Bool {
        checkInteger().isEven
    }

    public var isExact: Bool {
        switch value {
        case let .complex(val):
            val.isExact

        case let .real(val):
            val.isExact
        }
    }

    public var isFinite: Bool {
        switch value {
        case let .complex(val):
            val.isFinite

        case let .real(val):
            val.isFinite
        }
    }

    public var isInexact: Bool {
        switch value {
        case let .complex(val):
            val.isInexact

        case let .real(val):
            val.isInexact
        }
    }

    public var isInfinite: Bool {
        switch value {
        case let .complex(val):
            val.isInfinite

        case let .real(val):
            val.isInfinite
        }
    }

    public var isInteger: Bool {
        switch value {
        case let .complex(val):
            val.isInteger

        case let .real(val):
            val.isInteger
        }
    }

    public var isNaN: Bool {
        switch value {
        case let .complex(val):
            val.isNaN

        case let .real(val):
            val.isNaN
        }
    }

    public var isNegative: Bool {
        checkReal().isNegative
    }

    public var isOdd: Bool {
        checkInteger().isOdd
    }

    public var isPositive: Bool {
        checkReal().isPositive
    }

    public var isRational: Bool {
        switch value {
        case let .complex(val):
            val.isRational

        case let .real(val):
            val.isRational
        }
    }

    public var isReal: Bool {
        switch value {
        case let .complex(val):
            val.isReal

        case .real:
            true
        }
    }

    public var isZero: Bool {
        switch value {
        case let .complex(val):
            val.isZero

        case let .real(val):
            val.isZero
        }
    }

    public var magnitude: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.magnitude))

        case let .real(val):
            Self(.real(val.absoluteValue()))
        }
    }

    public var numerator: Self {
        Self(.real(checkRational().numerator))
    }

    public var realPart: Self {
        switch value {
        case let .complex(val):
            Self(.real(val.realPart))

        case .real:
            self
        }
    }

    public var simplified: Self {
        switch value {
        case let .complex(val):
            if val.isReal {
                Self(.real(val.realPart.simplified))
            } else {
                Self(.complex(Complex(realPart: val.realPart.simplified,
                                      imaginaryPart: val.imaginaryPart.simplified)))
            }

        case let .real(val):
            Self(.real(val.simplified))
        }
    }
}
