// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct ComplexTests {
}

// MARK: - Test internal type methods

extension ComplexTests {
    @Test
    func fromPolar_magnitude_angle() {}

    @Test
    func parse_radix_exactness() {}
}

// MARK: - Test internal initializers

extension ComplexTests {
    @Test
    func init_real_imaginary() {}
}

// MARK: - Test internal instance properties

extension ComplexTests {
    @Test
    func angle() {}

    @Test
    func conjugate() {}

    @Test
    func debugDescription() {}

    @Test
    func description() {}

    @Test
    func exact() {}

    @Test
    func imaginary() {}

    @Test
    func isExact() {}

    @Test
    func isFinite() {}

    @Test
    func isInexact() {}

    @Test
    func isInfinite() {}

    @Test
    func isInteger() {}

    @Test
    func isNaN() {}

    @Test
    func isRational() {}

    @Test
    func isReal() {}

    @Test
    func isZero() {}

    @Test
    func magnitude() {}

    @Test
    func real() {}
}

// MARK: - Test internal instance methods

extension ComplexTests {
    @Test
    func adding() {
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
    func cosine() {}

    @Test
    func divided_by() {
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
    func exponential() {}

    @Test
    func hyperbolicCosine() {}

    @Test
    func hyperbolicSine() {}

    @Test
    func hyperbolicTangent() {}

    @Test
    func inverseCosine() {}

    @Test
    func inverseHyperbolicCosine() {}

    @Test
    func inverseHyperbolicSine() {}

    @Test
    func inverseHyberbolicTangent() {}

    @Test
    func inverseSine() {}

    @Test
    func inverseTangent() {}

    @Test
    func isEqual_to() {}

    @Test
    func logarithm() {}

    @Test
    func multiplied_by() {
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
    func negated() {}

    @Test
    func power() {}

    @Test
    func sine() {
        #expect(_cx(-2, 3).sine().testEqual(to: _cx(-9.1544991469114301, -3.8537380379193769)))
//        #expect(_cx(-3, -4).sine().testEqual(to: _cx(1.2246467991473532e-16, 0.0)))
//        #expect(_cx(Double.pi, 0).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(0, Double.pi).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(0, 0).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(0.5, 0.5).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(1, 2).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(1, 1).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(0, 2).sine().testEqual(to: _cx(0, 0)))
//        #expect(_cx(4, 5).sine().testEqual(to: _cx(0, 0)))
    }

    @Test
    func squareRoot() {
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
    func subtracting() {
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
    func tangent() {}
}

// MARK: -

// MARK: -

extension ComplexTests {
    private func _cx<T: BinaryInteger>(_ rval: T,
                                       _ ival: T) -> Complex {
        Complex(real: Real(rval),
                imaginary: Real(ival))
    }

    private func _cx<T: BinaryFloatingPoint>(_ rval: T,
                                             _ ival: T) -> Complex {
        Complex(real: Real(rval),
                imaginary: Real(ival))
    }

    private func _cx(_ rval: Fraction,
                     _ ival: Fraction) -> Complex {
        Complex(real: Real(numerator: rval.numerator,
                           denominator: rval.denominator),
                imaginary: Real(numerator: ival.numerator,
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
            let rval1 = real.floatingPointValue.doubleValue
            let rval2 = other.real.floatingPointValue.doubleValue
            let ival1 = imaginary.floatingPointValue.doubleValue
            let ival2 = other.imaginary.floatingPointValue.doubleValue

            return rval1.isApproximatelyEqual(to: rval2) && ival1.isApproximatelyEqual(to: ival2)
        } else {
            let rval1 = real
            let rval2 = other.real
            let ival1 = imaginary
            let ival2 = other.imaginary

            return rval1.isEqual(to: rval2) && ival1.isEqual(to: ival2)
        }
    }
}
