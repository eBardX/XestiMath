// © 2025–2026 John Gary Pusey (see LICENSE.md)

import RealModule
import Testing
@testable import XestiMath

struct ComplexTests {
}

// MARK: - Test internal type methods

extension ComplexTests {
    @Test
    func test_fromPolar_magnitude_angle() {
        let c1 = Complex.fromPolar(magnitude: Real(1), angle: Real(0.0))

        #expect(c1.testEqual(to: _cx(1.0, 0.0)))

        let c2 = Complex.fromPolar(magnitude: Real(2.0), angle: Real(Double.pi / 4))
        let sqrt2 = 1.4142135623730951

        #expect(c2.testEqual(to: _cx(sqrt2, sqrt2)))

        let c3 = Complex.fromPolar(magnitude: Real(5.0), angle: Real(0.9272952180016122))

        #expect(c3.testEqual(to: _cx(3.0, 4.0)))

        let c4 = Complex.fromPolar(magnitude: Real(0.0), angle: Real(0.0))

        #expect(c4.testEqual(to: _cx(0.0, 0.0)))
    }

    @Test
    func test_parse_radix_exactness() {
        let c1 = Complex.parse(input: "3+4i", radix: .decimal, exactness: .unspecified)

        #expect(c1?.testEqual(to: _cx(3, 4)) == true)

        let c2 = Complex.parse(input: "3-4i", radix: .decimal, exactness: .unspecified)

        #expect(c2?.testEqual(to: _cx(3, -4)) == true)

        let c3 = Complex.parse(input: "0+0i", radix: .decimal, exactness: .unspecified)

        #expect(c3?.testEqual(to: _cx(0, 0)) == true)

        #expect(Complex.parse(input: "invalid", radix: .decimal, exactness: .unspecified) == nil)
    }
}

// MARK: - Test internal initializers

extension ComplexTests {
    @Test
    func test_init_real_imaginary() {
        let c1 = Complex(realPart: Real(3), imaginaryPart: Real(4))

        #expect(c1.realPart.isEqual(to: Real(3)))
        #expect(c1.imaginaryPart.isEqual(to: Real(4)))

        let c2 = Complex(realPart: Real(0), imaginaryPart: Real(0))

        #expect(c2.isZero)

        let c3 = Complex(realPart: Real(1.5), imaginaryPart: Real(-2.5))

        #expect(c3.testEqual(to: _cx(1.5, -2.5)))
    }
}

// MARK: - Test internal instance properties

extension ComplexTests {
    @Test
    func test_angle() {
        let c1 = _cx(1, 0)

        #expect(c1.angle.floatingPointValue.doubleValue == 0.0)

        let c2 = _cx(0, 1)

        #expect(c2.angle.floatingPointValue.doubleValue == Double.pi / 2)

        let c3 = _cx(-1, 0)

        #expect(c3.angle.floatingPointValue.doubleValue == Double.pi)

        #expect(_cx(0, 0).angle.isNaN)
    }

    @Test
    func test_conjugate() {
        #expect(_cx(3, 4).conjugate.testEqual(to: _cx(3, -4)))
        #expect(_cx(3, -4).conjugate.testEqual(to: _cx(3, 4)))
        #expect(_cx(0, 0).conjugate.testEqual(to: _cx(0, 0)))
        #expect(_cx(5, 0).conjugate.testEqual(to: _cx(5, 0)))
    }

    @Test
    func test_debugDescription() {
        #expect(_cx(3, 4).debugDescription == "complex<small<3>, small<4>>")
        #expect(_cx(-1, 2).debugDescription == "complex<small<-1>, small<2>>")
        #expect(_cx(0, 0).debugDescription == "complex<small<0>, small<0>>")
    }

    @Test
    func test_description() {
        #expect(_cx(3, 4).description == "3+4i")
        #expect(_cx(3, -4).description == "3-4i")
        #expect(_cx(0, 0).description == "0+0i")
        #expect(_cx(-1, 2).description == "-1+2i")
    }

    @Test
    func test_exact() {
        let c1 = _cx(1.5, 2.5).exact

        #expect(c1.isExact)

        let c2 = _cx(3, 4).exact

        #expect(c2.isExact)
        #expect(c2.testEqual(to: _cx(3, 4)))
    }

    @Test
    func test_imaginary() {
        #expect(_cx(3, 4).imaginaryPart.isEqual(to: Real(4)))
        #expect(_cx(0, -5).imaginaryPart.isEqual(to: Real(-5)))
        #expect(_cx(3, 0).imaginaryPart.isEqual(to: Real(0)))
    }

    @Test
    func test_isExact() {
        #expect(_cx(3, 4).isExact)
        #expect(_cx(_fr(1, 2), _fr(3, 4)).isExact)
        #expect(!_cx(1.5, 2.5).isExact)
    }

    @Test
    func test_isFinite() {
        #expect(_cx(3, 4).isFinite)
        #expect(_cx(0, 0).isFinite)
        #expect(!_cx(Double.infinity, 0.0).isFinite)
        #expect(!_cx(0.0, Double.infinity).isFinite)
    }

    @Test
    func test_isInexact() {
        #expect(_cx(1.5, 2.5).isInexact)
        #expect(!_cx(3, 4).isInexact)
    }

    @Test
    func test_isInfinite() {
        #expect(!_cx(3, 4).isInfinite)
        #expect(_cx(Double.infinity, 0.0).isInfinite)
        #expect(_cx(0.0, Double.infinity).isInfinite)
    }

    @Test
    func test_isInteger() {
        #expect(_cx(3, 0).isInteger)
        #expect(!_cx(3, 4).isInteger)
        #expect(!_cx(_fr(1, 2), _fr(0, 1)).isInteger)
    }

    @Test
    func test_isNaN() {
        #expect(!_cx(3, 4).isNaN)
        #expect(_cx(Double.nan, 0.0).isNaN)
        #expect(_cx(0.0, Double.nan).isNaN)
    }

    @Test
    func test_isRational() {
        #expect(_cx(3, 0).isRational)
        #expect(_cx(_fr(1, 2), _fr(0, 1)).isRational)
        #expect(!_cx(3, 4).isRational)
    }

    @Test
    func test_isReal() {
        #expect(_cx(3, 0).isReal)
        #expect(_cx(0, 0).isReal)
        #expect(!_cx(3, 4).isReal)
        #expect(!_cx(0, 1).isReal)
    }

    @Test
    func test_isZero() {
        #expect(_cx(0, 0).isZero)
        #expect(!_cx(1, 0).isZero)
        #expect(!_cx(0, 1).isZero)
        #expect(!_cx(1, 1).isZero)
    }

    @Test
    func test_magnitude() {
        let c1 = _cx(3, 4)

        #expect(c1.magnitude.floatingPointValue.doubleValue == 5.0)

        let c2 = _cx(0, 0)

        #expect(c2.magnitude.floatingPointValue.doubleValue == 0.0)

        let c3 = _cx(1, 0)

        #expect(c3.magnitude.floatingPointValue.doubleValue == 1.0)
    }

    @Test
    func test_real() {
        #expect(_cx(3, 4).realPart.isEqual(to: Real(3)))
        #expect(_cx(-5, 2).realPart.isEqual(to: Real(-5)))
        #expect(_cx(0, 7).realPart.isEqual(to: Real(0)))
    }
}

// MARK: - Test internal instance methods

extension ComplexTests {
    @Test
    func test_adding() {
        #expect(_cx(-1, -2).adding(_cx(-3, 4)).testEqual(to: _cx(-4, 2)))
        #expect(_cx(0, 5).adding(_cx(0, 3)).testEqual(to: _cx(0, 8)))
        #expect(_cx(1_000, 2_000).adding(_cx(5_000, -1_000)).testEqual(to: _cx(6_000, 1_000)))
        #expect(_cx(2, 3).adding(_cx(0, 4)).testEqual(to: _cx(2, 7)))
        #expect(_cx(2.5, 3.75).adding(_cx(1.25, -4.5)).testEqual(to: _cx(3.75, -0.75)))
        #expect(_cx(3, 4).adding(_cx(1, 2)).testEqual(to: _cx(4, 6)))
        #expect(_cx(3, 5).adding(_cx(3, -5)).testEqual(to: _cx(6, 0)))
        #expect(_cx(5, 2).adding(_cx(3, 0)).testEqual(to: _cx(8, 2)))
        #expect(_cx(6, 2).adding(_cx(-6, -2)).testEqual(to: _cx(0, 0)))
        #expect(_cx(7, 8).adding(_cx(0, 0)).testEqual(to: _cx(7, 8)))
    }

    @Test
    func test_cosine() {
        #expect(_cx(0.0, 0.0).cosine().testEqual(to: _cx(1.0, 0.0)))
        #expect(_cx(Double.pi, 0.0).cosine().testEqual(to: _cx(-1.0, 0.0)))
        #expect(_cx(1.0, 1.0).cosine().testEqual(to: _cx(0.8337300251311491, -0.9888977057628651)))
    }

    @Test
    func test_divided_by() {
        #expect(_cx(-2, 5).divided(by: _cx(1, 3)).testEqual(to: _cx(_fr(13, 10), _fr(11, 10))))
        #expect(_cx(0, 1).divided(by: _cx(1, 0)).testEqual(to: _cx(0, 1)))
        #expect(_cx(0, 4).divided(by: _cx(2, 0)).testEqual(to: _cx(0, 2)))
        #expect(_cx(1_000, 1_000).divided(by: _cx(500, 500)).testEqual(to: _cx(2, 0)))
        #expect(_cx(3, 2).divided(by: _cx(3, 2)).testEqual(to: _cx(1, 0)))
        #expect(_cx(3, 4).divided(by: _cx(0, 2)).testEqual(to: _cx(_fr(2, 1), _fr(-3, 2))))
        #expect(_cx(3, 4).divided(by: _cx(1, 2)).testEqual(to: _cx(_fr(11, 5), _fr(-2, 5))))
        #expect(_cx(3.0, 4.0).divided(by: _cx(0, 0)).isNaN)
        #expect(_cx(4, 0).divided(by: _cx(2, 0)).testEqual(to: _cx(2, 0)))
        #expect(_cx(4, 3).divided(by: _cx(2, 0)).testEqual(to: _cx(_fr(2, 1), _fr(3, 2))))
    }

    @Test
    func test_exponential() {
        #expect(_cx(0.0, 0.0).exponential().testEqual(to: _cx(1.0, 0.0)))
        #expect(_cx(1.0, 0.0).exponential().testEqual(to: _cx(2.718281828459045, 0.0)))
        #expect(_cx(1.0, 1.0).exponential().testEqual(to: _cx(1.4686939399158851, 2.2873552871788423)))
    }

    @Test
    func test_hyperbolicCosine() {
        #expect(_cx(0.0, 0.0).hyperbolicCosine().testEqual(to: _cx(1.0, 0.0)))
        #expect(_cx(1.0, 0.0).hyperbolicCosine().testEqual(to: _cx(1.5430806348152437, 0.0)))
    }

    @Test
    func test_hyperbolicSine() {
        #expect(_cx(0.0, 0.0).hyperbolicSine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).hyperbolicSine().testEqual(to: _cx(1.1752011936438014, 0.0)))
    }

    @Test
    func test_hyperbolicTangent() {
        #expect(_cx(0.0, 0.0).hyperbolicTangent().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).hyperbolicTangent().testEqual(to: _cx(0.7615941559557649, 0.0)))
    }

    @Test
    func test_inverseCosine() {
        #expect(_cx(1.0, 0.0).inverseCosine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(0.0, 0.0).inverseCosine().testEqual(to: _cx(1.5707963267948966, 0.0)))
    }

    @Test
    func test_inverseHyperbolicCosine() {
        #expect(_cx(1.0, 0.0).inverseHyperbolicCosine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(2.0, 0.0).inverseHyperbolicCosine().testEqual(to: _cx(1.3169578969248166, 0.0)))
    }

    @Test
    func test_inverseHyperbolicSine() {
        #expect(_cx(0.0, 0.0).inverseHyperbolicSine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).inverseHyperbolicSine().testEqual(to: _cx(0.881373587019543, 0.0)))
    }

    @Test
    func test_inverseHyperbolicTangent() {
        #expect(_cx(0.0, 0.0).inverseHyperbolicTangent().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(0.5, 0.0).inverseHyperbolicTangent().testEqual(to: _cx(0.5493061443340549, 0.0)))
    }

    @Test
    func test_inverseSine() {
        #expect(_cx(0.0, 0.0).inverseSine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).inverseSine().testEqual(to: _cx(1.5707963267948966, 0.0)))
    }

    @Test
    func test_inverseTangent() {
        #expect(_cx(0.0, 0.0).inverseTangent().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).inverseTangent().testEqual(to: _cx(0.7853981633974483, 0.0)))
    }

    @Test
    func test_isEqual_to() {
        #expect(_cx(3, 4).isEqual(to: _cx(3, 4)))
        #expect(!_cx(3, 4).isEqual(to: _cx(4, 3)))
        #expect(!_cx(3, 4).isEqual(to: _cx(3, -4)))
        #expect(_cx(0, 0).isEqual(to: _cx(0, 0)))
    }

    @Test
    func test_logarithm() {
        #expect(_cx(1.0, 0.0).logarithm().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(2.718281828459045, 0.0).logarithm().testEqual(to: _cx(1.0, 0.0)))
        #expect(_cx(-1.0, 0.0).logarithm().testEqual(to: _cx(0.0, Double.pi)))
    }

    @Test
    func test_multiplied_by() {
        #expect(_cx(-1, 2).multiplied(by: _cx(2, -3)).testEqual(to: _cx(4, 7)))
        #expect(_cx(-3, 2).multiplied(by: _cx(-3, -4)).testEqual(to: _cx(17, 6)))
        #expect(_cx(0, 1).multiplied(by: _cx(0, 1)).testEqual(to: _cx(-1, 0)))
        #expect(_cx(1, -2).multiplied(by: _cx(1, 2)).testEqual(to: _cx(5, 0)))
        #expect(_cx(1, 0).multiplied(by: _cx(0, 1)).testEqual(to: _cx(0, 1)))
        #expect(_cx(2, 3).multiplied(by: _cx(4, -5)).testEqual(to: _cx(23, 2)))
        #expect(_cx(3, 4).multiplied(by: _cx(1, 2)).testEqual(to: _cx(-5, 10)))
        #expect(_cx(5, 2).multiplied(by: _cx(1, -4)).testEqual(to: _cx(13, -18)))
        #expect(_cx(6, 8).multiplied(by: _cx(0, -2)).testEqual(to: _cx(16, -12)))
        #expect(_cx(7, -3).multiplied(by: _cx(-2, 5)).testEqual(to: _cx(1, 41)))
    }

    @Test
    func test_negated() {
        #expect(_cx(3, 4).negated().testEqual(to: _cx(-3, -4)))
        #expect(_cx(-3, -4).negated().testEqual(to: _cx(3, 4)))
        #expect(_cx(0, 0).negated().testEqual(to: _cx(0, 0)))
        #expect(_cx(1, -2).negated().testEqual(to: _cx(-1, 2)))
    }

    @Test
    func test_power() {
        #expect(_cx(2.0, 0.0).exponential(base: _cx(3.0, 0.0)).testEqual(to: _cx(9.0, 0.0)))
        #expect(_cx(0.0, 0.0).exponential(base: _cx(5.0, 0.0)).testEqual(to: _cx(1.0, 0.0)))
        #expect(_cx(1.0, 0.0).exponential(base: _cx(7.0, 0.0)).testEqual(to: _cx(7.0, 0.0)))
    }

    @Test
    func test_sine() {
        #expect(_cx(0.0, 0.0).sine().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(Double.pi, 0.0).sine().testEqual(to: _cx(1.2246467991473532e-16, 0.0)))
        #expect(_cx(1.0, 1.0).sine().testEqual(to: _cx(1.2984575814159773, 0.6349639147847361)))
    }

    @Test
    func test_squareRoot() {
        #expect(_cx(-3, -4).squareRoot().testEqual(to: _cx(1, -2)))
        #expect(_cx(-9, 0).squareRoot().testEqual(to: _cx(0, 3)))
        #expect(_cx(0, -4).squareRoot().testEqual(to: _cx(1.4142135623730951, -1.4142135623730949)))
        #expect(_cx(0, 0).squareRoot().testEqual(to: _cx(0, 0)))
        #expect(_cx(0, 4).squareRoot().testEqual(to: _cx(1.4142135623730951, 1.4142135623730949)))
        #expect(_cx(0.0001, 0.0001).squareRoot().testEqual(to: _cx(0.010986841134678101, 0.0045508986056222731)))
        #expect(_cx(1_000, 1_000).squareRoot().testEqual(to: _cx(34.743442276011564, 14.391204994250742)))
        #expect(_cx(1_000_000, 0).squareRoot().testEqual(to: _cx(1_000, 0)))
        #expect(_cx(3, 4).squareRoot().testEqual(to: _cx(2, 1)))
        #expect(_cx(9, 0).squareRoot().testEqual(to: _cx(3, 0)))
    }

    @Test
    func test_subtracting() {
        #expect(_cx(-4, 2).subtracting(_cx(-3, 4)).testEqual(to: _cx(-1, -2)))
        #expect(_cx(0, 0).subtracting(_cx(-6, -2)).testEqual(to: _cx(6, 2)))
        #expect(_cx(0, 8).subtracting(_cx(0, 3)).testEqual(to: _cx(0, 5)))
        #expect(_cx(2, 7).subtracting(_cx(0, 4)).testEqual(to: _cx(2, 3)))
        #expect(_cx(3.75, -0.75).subtracting(_cx(1.25, -4.5)).testEqual(to: _cx(2.5, 3.75)))
        #expect(_cx(4, 6).subtracting(_cx(1, 2)).testEqual(to: _cx(3, 4)))
        #expect(_cx(6, 0).subtracting(_cx(3, -5)).testEqual(to: _cx(3, 5)))
        #expect(_cx(6_000, 1_000).subtracting(_cx(5_000, -1_000)).testEqual(to: _cx(1_000, 2_000)))
        #expect(_cx(7, 8).subtracting(_cx(0, 0)).testEqual(to: _cx(7, 8)))
        #expect(_cx(8, 2).subtracting(_cx(3, 0)).testEqual(to: _cx(5, 2)))
    }

    @Test
    func test_tangent() {
        #expect(_cx(0.0, 0.0).tangent().testEqual(to: _cx(0.0, 0.0)))
        #expect(_cx(1.0, 0.0).tangent().testEqual(to: _cx(1.5574077246549023, 0.0)))
        #expect(_cx(0.0, 1.0).tangent().testEqual(to: _cx(0.0, 0.7615941559557649)))
    }
}

// MARK: -

extension ComplexTests {
    private func _cx<T: BinaryInteger>(_ rval: T,
                                       _ ival: T) -> Complex {
        Complex(realPart: Real(rval),
                imaginaryPart: Real(ival))
    }

    private func _cx<T: BinaryFloatingPoint>(_ rval: T,
                                             _ ival: T) -> Complex {
        Complex(realPart: Real(rval),
                imaginaryPart: Real(ival))
    }

    private func _cx(_ rval: Fraction,
                     _ ival: Fraction) -> Complex {
        Complex(realPart: Real(numerator: rval.numerator,
                               denominator: rval.denominator),
                imaginaryPart: Real(numerator: ival.numerator,
                                    denominator: ival.denominator))
    }

    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }

    private func _fr<T: BinaryInteger>(_ num: T,
                                       _ den: T) -> Fraction {
        Fraction(numerator: _ei(num),
                 denominator: _ei(den))
    }
}

// MARK: -

extension Complex {
    internal func testEqual(to other: Self) -> Bool {
        if isInexact || other.isInexact {
            let rval1 = realPart.floatingPointValue.doubleValue
            let rval2 = other.realPart.floatingPointValue.doubleValue
            let ival1 = imaginaryPart.floatingPointValue.doubleValue
            let ival2 = other.imaginaryPart.floatingPointValue.doubleValue

            return rval1.isApproximatelyEqual(to: rval2) && ival1.isApproximatelyEqual(to: ival2)
        } else {
            let rval1 = realPart
            let rval2 = other.realPart
            let ival1 = imaginaryPart
            let ival2 = other.imaginaryPart

            return rval1.isEqual(to: rval2) && ival1.isEqual(to: ival2)
        }
    }
}
