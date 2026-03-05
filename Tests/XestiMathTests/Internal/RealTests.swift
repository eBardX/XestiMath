// © 2025—2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct RealTests {
}

// MARK: - Test internal type methods

extension RealTests {
    @Test
    func test_parse_radix_exactness() {}
}

// MARK: - Test internal initializers

extension RealTests {
    @Test
    func test_init_binaryFloatingPoint() {}

    @Test
    func test_init_binaryInteger() {}
}

// MARK: - Test internal instance properties

// swiftlint:disable force_unwrapping

extension RealTests {
    @Test
    func test_angle() {}

    @Test
    func test_debugDescription() {}

    @Test
    func test_denominator() {}

    @Test
    func test_description() {}

    @Test
    func test_exact() {
        #expect(Real.inexactOne.exact.isEqual(to: .exactOne))
        #expect(Real.pi.exact.isEqual(to: _fr(355, 113)))
        #expect(Real.inexactZero.exact.isEqual(to: .exactZero))
        #expect(_fp(-0.0).exact.isEqual(to: _ei(0)))
        #expect(_fp(-1).exact.isEqual(to: _ei(-1)))
        #expect(_fp(5_836_472.0).exact.isEqual(to: _ei(5_836_472)))
        #expect(_fp(-5_836_472.0).exact.isEqual(to: _ei(-5_836_472)))
        #expect(_fp(583.6472).exact.isEqual(to: _fr(239_879, 411)))
        #expect(_fp(-583.6472).exact.isEqual(to: _fr(-239_879, 411)))
        #expect(_fp(0.5836472).exact.isEqual(to: _fr(157, 269)))
        #expect(_fp(-0.5836472).exact.isEqual(to: _fr(-157, 269)))
    }

    @Test
    func test_exactIntegerValue() {}

    @Test
    func test_floatingPointValue() {}

    @Test
    func test_inexact() {}

    @Test
    func test_isEven() {}

    @Test
    func test_isExact() {}

    @Test
    func test_isFinite() {}

    @Test
    func test_isInexact() {}

    @Test
    func test_isInfinite() {}

    @Test
    func test_isInteger() {}

    @Test
    func test_isNaN() {}

    @Test
    func test_isNegative() {}

    @Test
    func test_isOdd() {}

    @Test
    func test_isPositive() {}

    @Test
    func test_isRational() {}

    @Test
    func test_isZero() {}

    @Test
    func test_numerator() {}

    @Test
    func test_simplified() {}
}

// MARK: - Test internal instance methods

extension RealTests {
    @Test
    func test_absoluteValue() {}

    @Test
    func test_adding() {}

    @Test
    func test_bitwiseAnd_with() {}

    @Test
    func test_bitwiseNot() {}

    @Test
    func test_bitwiseOr_with() {}

    @Test
    func test_bitwiseShiftLeft_bits() {}

    @Test
    func test_bitwiseShiftRight_bits() {}

    @Test
    func test_bitwiseXor_with() {}

    @Test
    func test_ceiling() {}

    @Test
    func test_compare_to() {}

    @Test
    func test_cosine() {}

    @Test
    func test_divided_by() {}

    @Test
    func test_exponential() {}

    @Test
    func test_exponential_base() {}

    @Test
    func test_exponentialBase2() {}

    @Test
    func test_exponentialBase10() {}

    @Test
    func test_floor() {}

    @Test
    func test_greatestCommonDivisor_with() {}

    @Test
    func test_hyperbolicCosine() {}

    @Test
    func test_hyperbolicSine() {}

    @Test
    func test_hyperbolicTangent() {}

    @Test
    func test_hypotenuse_with() {}

    @Test
    func test_inverseCosine() {}

    @Test
    func test_inverseHyperbolicCosine() {}

    @Test
    func test_inverseHyperbolicSine() {}

    @Test
    func test_inverseHyberbolicTangent() {}

    @Test
    func test_inverseSine() {}

    @Test
    func test_inverseTangent() {}

    @Test
    func test_inverseTangent2() {}

    @Test
    func test_isEqual_to() {}

    @Test
    func test_leastCommonMultiple_with() {}

    @Test
    func test_logarithm() {}

    @Test
    func test_logarithm_base() {}

    @Test
    func test_logarithmBase2() {}

    @Test
    func test_logarithmBase10() {}

    @Test
    func test_modulo() {}

    @Test
    func test_multiplied_by() {}

    @Test
    func test_negated() {}

    @Test
    func test_quotient_dividingBy() {}

    @Test
    func test_power() {}

    @Test
    func test_rationalize() {
        #expect(Real.pi.exact.rationalize(within: _fr(1, 10))!.isEqual(to: _fr(16, 5)))
        #expect(Real.pi.exact.rationalize(within: _fr(1, 100))!.isEqual(to: _fr(22, 7)))
        #expect(Real.pi.exact.rationalize(within: _fr(1, 1_000))!.isEqual(to: _fr(201, 64)))
        #expect(Real.pi.exact.rationalize(within: _fr(1, 10_000))!.isEqual(to: _fr(333, 106)))
        #expect(Real.pi.exact.rationalize(within: _fr(1, 100_000))!.isEqual(to: _fr(355, 113)))
        #expect(Real.pi.exact.rationalize(within: _fr(1, 1_000_000))!.isEqual(to: _fr(355, 113)))

        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 10))!.isEqual(to: _fr(-16, 5)))
        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 100))!.isEqual(to: _fr(-22, 7)))
        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 1_000))!.isEqual(to: _fr(-201, 64)))
        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 10_000))!.isEqual(to: _fr(-333, 106)))
        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 100_000))!.isEqual(to: _fr(-355, 113)))
        #expect(Real.pi.negated().exact.rationalize(within: _fr(1, 1_000_000))!.isEqual(to: _fr(-355, 113)))

        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 10))!.isEqual(to: _fr(1, 2)))
        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 100))!.isEqual(to: _fr(7, 12)))
        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 1_000))!.isEqual(to: _fr(7, 12)))
        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 10_000))!.isEqual(to: _fr(122, 209)))
        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 100_000))!.isEqual(to: _fr(157, 269)))
        #expect(_fp(0.5836472).exact.rationalize(within: _fr(1, 1_000_000))!.isEqual(to: _fr(157, 269)))

        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 10))!.isEqual(to: _fr(-1, 2)))
        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 100))!.isEqual(to: _fr(-7, 12)))
        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 1_000))!.isEqual(to: _fr(-7, 12)))
        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 10_000))!.isEqual(to: _fr(-122, 209)))
        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 100_000))!.isEqual(to: _fr(-157, 269)))
        #expect(_fp(-0.5836472).exact.rationalize(within: _fr(1, 1_000_000))!.isEqual(to: _fr(-157, 269)))
    }

    @Test
    func test_remainder_dividingBy() {}

    @Test
    func test_round() {}

    @Test
    func test_sine() {}

    @Test
    func test_squareRoot() {}

    @Test
    func test_subtracting() {}

    @Test
    func test_tangent() {}

    @Test
    func test_truncate() {}
}

// MARK: -

 extension RealTests {
     private func _ei<T: BinaryInteger>(_ val: T) -> Real {
         Real(.exactInteger(ExactInteger(val)))
     }

     private func _fp<T: BinaryFloatingPoint>(_ val: T) -> Real {
         Real(.floatingPoint(FloatingPoint(val)))
     }

     private func _fr<T: BinaryInteger>(_ num: T,
                                        _ den: T) -> Real {
         Real(.fraction(Fraction(numerator: ExactInteger(num),
                                 denominator: ExactInteger(den))))
     }
}

// swiftlint:enable force_unwrapping
