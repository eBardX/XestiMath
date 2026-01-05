// © 2025 John Gary Pusey (see LICENSE.md)

import ComplexModule
import RealModule

internal struct Complex {

    // MARK: Private Type Properties

    private static let undefined = Self(.nan, .nan)

    // MARK: Private Initializers

    private init(_ rvalue: Real,
                 _ ivalue: Real) {
        self.ivalue = ivalue
        self.rvalue = rvalue
    }

    // MARK: Private Instance Properties

    private let ivalue: Real
    private let rvalue: Real
}

// MARK: -

extension Complex {

    // MARK: Internal Type Methods

    internal static func fromPolar(magnitude: Real,
                                   angle: Real) -> Self {
        ExternalFormat(length: magnitude.floatingPointValue.doubleValue,
                       phase: angle.floatingPointValue.doubleValue)._toInternalFormat()
    }

    internal static func parse(_ text: String,
                               radix: Number.Radix,
                               exactness: Number.Exactness) -> Self? {
        let lcText = text.lowercased()

        if let (mtval, atval) = _matchComplexP(lcText,
                                               radix: radix),
           let mval = Real.parse(mtval,
                                 radix: radix,
                                 exactness: exactness),
           let aval = Real.parse(atval,
                                 radix: radix,
                                 exactness: exactness) {
            return Self.fromPolar(magnitude: mval,
                                  angle: aval)
        }

        if let (rtval, itval) = _matchComplexR(lcText,
                                               radix: radix),
           let rval = Real.parse(rtval,
                                 radix: radix,
                                 exactness: exactness),
           let ival = Real.parse(itval,
                                 radix: radix,
                                 exactness: exactness) {
            return Self(realPart: rval,
                        imaginaryPart: ival)
        }

        return nil
    }

    // MARK: Internal Initializers

    internal init(realPart: Real,
                  imaginaryPart: Real) {
        if realPart.isExact != imaginaryPart.isExact {
            self.init(realPart.inexact, imaginaryPart.inexact)
        } else {
            self.init(realPart, imaginaryPart)
        }
    }

    // MARK: Internal Instance Properties

    internal var angle: Real {
        guard rvalue.isFinite,
              ivalue.isFinite,
              !rvalue.isZero || !ivalue.isZero
        else { return .nan }

        return ivalue.inverseTangent(rvalue)
    }

    internal var conjugate: Self {
        Self(realPart: rvalue,
             imaginaryPart: ivalue.negated())
    }

    internal var debugDescription: String {
        "complex<\(rvalue.debugDescription), \(ivalue.debugDescription)>"
    }

    internal var description: String {
        if ivalue.isNegative {
            "\(rvalue.description)\(ivalue.description)i"
        } else {
            "\(rvalue.description)+\(ivalue.description)i"
        }
    }

    internal var exact: Self {
        if rvalue.isInexact || ivalue.isInexact {
            Self(realPart: rvalue.exact,
                 imaginaryPart: ivalue.exact)
        } else {
            self
        }
    }

    internal var imaginaryPart: Real {
        guard rvalue.isFinite,
              ivalue.isFinite
        else { return .nan }

        return ivalue
    }

    internal var inexact: Self {
        if rvalue.isExact || ivalue.isExact {
            Self(realPart: rvalue.inexact,
                 imaginaryPart: ivalue.inexact)
        } else {
            self
        }
    }

    internal var isExact: Bool {
        rvalue.isExact && ivalue.isExact
    }

    internal var isFinite: Bool {
        rvalue.isFinite && ivalue.isFinite
    }

    internal var isInexact: Bool {
        rvalue.isInexact || ivalue.isInexact
    }

    internal var isInfinite: Bool {
        rvalue.isInfinite || ivalue.isInfinite
    }

    internal var isInteger: Bool {
        rvalue.isInteger && ivalue.isZero
    }

    internal var isNaN: Bool {
        rvalue.isNaN || ivalue.isNaN
    }

    internal var isRational: Bool {
        rvalue.isRational && ivalue.isZero
    }

    internal var isReal: Bool {
        ivalue.isZero
    }

    internal var isZero: Bool {
        rvalue.isZero && ivalue.isZero
    }

    internal var magnitude: Real {
        guard rvalue.isFinite,
              ivalue.isFinite
        else { return .positiveInfinity }

        return rvalue.hypotenuse(with: ivalue)
    }

    internal var realPart: Real {
        guard rvalue.isFinite,
              ivalue.isFinite
        else { return .nan }

        return rvalue
    }

    // MARK: Internal Instance Methods

    internal func adding(_ other: Self) -> Self {
        Self(realPart: rvalue.adding(other.rvalue),
             imaginaryPart: ivalue.adding(other.ivalue))
    }

    internal func cosine() -> Self {
        ExternalFormat.cos(_toExternalFormat())._toInternalFormat()
    }

    internal func divided(by other: Self) -> Self {
        (_toExternalFormat() / other._toExternalFormat())._toInternalFormat()
    }

    internal func exponential() -> Self {
        ExternalFormat.exp(_toExternalFormat())._toInternalFormat()
    }

    internal func exponential(base: Self) -> Self {
        ExternalFormat.exp(_toExternalFormat() * .log(base._toExternalFormat()))._toInternalFormat()
    }

    internal func exponentialBase10() -> Self {
        ExternalFormat.exp(_toExternalFormat() * Self.efLn10)._toInternalFormat()
    }

    internal func exponentialBase2() -> Self {
        ExternalFormat.exp(_toExternalFormat() * Self.efLn2)._toInternalFormat()
    }

    internal func hyperbolicCosine() -> Self {
        ExternalFormat.cosh(_toExternalFormat())._toInternalFormat()
    }

    internal func hyperbolicSine() -> Self {
        ExternalFormat.sinh(_toExternalFormat())._toInternalFormat()
    }

    internal func hyperbolicTangent() -> Self {
        ExternalFormat.tanh(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseCosine() -> Self {
        ExternalFormat.acos(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseHyperbolicCosine() -> Self {
        ExternalFormat.acosh(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseHyperbolicSine() -> Self {
        ExternalFormat.asinh(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseHyberbolicTangent() -> Self {
        ExternalFormat.atanh(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseSine() -> Self {
        ExternalFormat.asin(_toExternalFormat())._toInternalFormat()
    }

    internal func inverseTangent() -> Self {
        ExternalFormat.atan(_toExternalFormat())._toInternalFormat()
    }

    internal func isEqual(to other: Self) -> Bool {
        rvalue.isEqual(to: other.rvalue) && ivalue.isEqual(to: other.ivalue)
    }

    internal func logarithm() -> Self {
        ExternalFormat.log(_toExternalFormat())._toInternalFormat()
    }

    internal func logarithm(base: Self) -> Self {
        (ExternalFormat.log(_toExternalFormat()) / ExternalFormat.log(base._toExternalFormat()))._toInternalFormat()
    }

    internal func logarithmBase10() -> Self {
        (ExternalFormat.log(_toExternalFormat()) / Self.efLn10)._toInternalFormat()
    }

    internal func logarithmBase2() -> Self {
        (ExternalFormat.log(_toExternalFormat()) / Self.efLn2)._toInternalFormat()
    }

    internal func multiplied(by other: Self) -> Self {
        Self(realPart: rvalue.multiplied(by: other.rvalue).subtracting(ivalue.multiplied(by: other.ivalue)),
             imaginaryPart: rvalue.multiplied(by: other.ivalue).adding(ivalue.multiplied(by: other.rvalue)))
    }

    internal func negated() -> Self {
        Self(realPart: rvalue.negated(),
             imaginaryPart: ivalue.negated())
    }

    internal func power(_ other: Self) -> Self {
        ExternalFormat.pow(_toExternalFormat(), other._toExternalFormat())._toInternalFormat()
    }

    internal func sine() -> Self {
        ExternalFormat.sin(_toExternalFormat())._toInternalFormat()
    }

    internal func squareRoot() -> Self {
        ExternalFormat.sqrt(_toExternalFormat())._toInternalFormat()
    }

    internal func subtracting(_ other: Self) -> Self {
        Self(realPart: rvalue.subtracting(other.rvalue),
             imaginaryPart: ivalue.subtracting(other.ivalue))
    }

    internal func tangent() -> Self {
        ExternalFormat.tan(_toExternalFormat())._toInternalFormat()
    }

    // MARK: Private Nested Types

    private typealias ExternalFormat = ComplexModule.Complex<Double>
    private typealias InternalFormat = Self

    // MARK: Private Type Properties

    private static let efLn10: ExternalFormat = .init(.log(10), 0)
    private static let efLn2: ExternalFormat  = .init(.log(2), 0)

    // MARK: Private Type Methods

    private static func _matchComplexP(_ text: String,
                                       radix: Number.Radix) -> (String, String)? {
        let match = switch radix {
        case .binary:
            text.wholeMatch(of: Number.cxBinValueP)

        case .decimal:
            text.wholeMatch(of: Number.cxDecValueP)

        case .hexadecimal:
            text.wholeMatch(of: Number.cxHexValueP)

        case .octal:
            text.wholeMatch(of: Number.cxOctValueP)
        }

        guard let moutput = match?.1,
              let aoutput = match?.2
        else { return nil }

        return (String(moutput), String(aoutput))
    }

    private static func _matchComplexR(_ text: String,
                                       radix: Number.Radix) -> (String, String)? {
        let match = switch radix {
        case .binary:
            text.wholeMatch(of: Number.cxBinValueR)

        case .decimal:
            text.wholeMatch(of: Number.cxDecValueR)

        case .hexadecimal:
            text.wholeMatch(of: Number.cxHexValueR)

        case .octal:
            text.wholeMatch(of: Number.cxOctValueR)
        }

        guard let routput = match?.1,
              let ioutput = match?.2
        else { return nil }

        return (String(routput), String(ioutput))
    }

    // MARK: Private Instance Methods

    private func _toExternalFormat() -> ExternalFormat {
        ExternalFormat(realPart.floatingPointValue.doubleValue,
                       imaginaryPart.floatingPointValue.doubleValue)
    }
}

// MARK: - Sendable

extension Complex: Sendable {
}

// MARK: - ComplexModule.Complex Extensions

extension ComplexModule.Complex<Double> {
    fileprivate func _toInternalFormat() -> XestiMath.Complex {
        XestiMath.Complex(realPart: XestiMath.Real(real),
                          imaginaryPart: XestiMath.Real(imaginary))
    }
}
