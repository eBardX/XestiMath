// © 2025–2026 John Gary Pusey (see LICENSE.md)

// swiftlint:disable file_length

import Testing
@testable import XestiMath

struct RealTests {
}

// MARK: - Test internal type methods

extension RealTests {
    @Test
    func test_parse_radix_exactness() {
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .unspecified)?.isEqual(to: _ei(42)) == true)
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .exact)?.isEqual(to: _ei(42)) == true)
        #expect(Real.parse(input: "42", radix: .decimal, exactness: .inexact)?.isEqual(to: _fp(42.0)) == true)
        #expect(Real.parse(input: "3/4", radix: .decimal, exactness: .unspecified)?.isEqual(to: _fr(3, 4)) == true)
        #expect(Real.parse(input: "3/4", radix: .decimal, exactness: .inexact)?.isEqual(to: _fp(0.75)) == true)
        #expect(Real.parse(input: "3.14", radix: .decimal, exactness: .unspecified)?.isEqual(to: _fp(3.14)) == true)
        #expect(Real.parse(input: "3.14", radix: .decimal, exactness: .exact) == nil)
        #expect(Real.parse(input: "+inf.0", radix: .decimal, exactness: .unspecified)?.isInfinite == true)
        #expect(Real.parse(input: "+nan.0", radix: .decimal, exactness: .unspecified)?.isNaN == true)
        #expect(Real.parse(input: "101", radix: .binary, exactness: .unspecified)?.isEqual(to: _ei(5)) == true)
        #expect(Real.parse(input: "ff", radix: .hexadecimal, exactness: .unspecified)?.isEqual(to: _ei(255)) == true)
        #expect(Real.parse(input: "17", radix: .octal, exactness: .unspecified)?.isEqual(to: _ei(15)) == true)
        #expect(Real.parse(input: "xyz", radix: .decimal, exactness: .unspecified) == nil)
    }
}

// MARK: - Test internal initializers

extension RealTests {
    @Test
    func test_init_binaryFloatingPoint() {
        let r1 = Real(3.14)
        #expect(r1.isInexact)
        #expect(r1.isEqual(to: _fp(3.14)))

        let r2 = Real(0.0)
        #expect(r2.isZero)
        #expect(r2.isInexact)

        let r3 = Real(-2.5)
        #expect(r3.isNegative)
        #expect(r3.isInexact)
    }

    @Test
    func test_init_binaryInteger() {
        let r1 = Real(42)
        #expect(r1.isExact)
        #expect(r1.isEqual(to: _ei(42)))

        let r2 = Real(0)
        #expect(r2.isZero)
        #expect(r2.isExact)

        let r3 = Real(-7)
        #expect(r3.isNegative)
        #expect(r3.isExact)
    }
}

// MARK: - Test internal instance properties

// swiftlint:disable force_unwrapping

extension RealTests {
    @Test
    func test_angle() {
        #expect(_ei(5).angle.isEqual(to: .exactZero))
        #expect(_ei(-3).angle.isEqual(to: .pi))
        #expect(_fp(2.0).angle.isEqual(to: .inexactZero))
        #expect(_fp(-1.5).angle.isEqual(to: .pi))
        #expect(_fr(3, 4).angle.isEqual(to: .exactZero))
        #expect(_fr(-3, 4).angle.isEqual(to: .pi))
    }

    @Test
    func test_debugDescription() {
        #expect(_ei(42).debugDescription == "small<42>")
        #expect(_fp(3.14).debugDescription == "floatingPoint<3.14>")
        #expect(_fr(3, 4).debugDescription == "fraction<small<3>, small<4>>")
        #expect(Real.nan.debugDescription == "floatingPoint<+nan.0>")
        #expect(Real.positiveInfinity.debugDescription == "floatingPoint<+inf.0>")
        #expect(Real.negativeInfinity.debugDescription == "floatingPoint<-inf.0>")
        #expect(Real.inexactZero.debugDescription == "floatingPoint<0.0>")
    }

    @Test
    func test_denominator() {
        #expect(_ei(42).denominator.isEqual(to: .exactOne))
        #expect(_fp(5.0).denominator.isEqual(to: .inexactOne))
        #expect(_fr(3, 4).denominator.isEqual(to: _ei(4)))
        #expect(_fr(7, 2).denominator.isEqual(to: _ei(2)))
    }

    @Test
    func test_description() {
        #expect(_ei(42).description == "42")
        #expect(_ei(-7).description == "-7")
        #expect(_fp(3.14).description == "3.14")
        #expect(_fr(3, 4).description == "3/4")
        #expect(Real.nan.description == "+nan.0")
        #expect(Real.positiveInfinity.description == "+inf.0")
        #expect(Real.negativeInfinity.description == "-inf.0")
        #expect(Real.inexactZero.description == "0.0")
    }

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
    func test_exactIntegerValue() {
        #expect(_ei(42).exactIntegerValue.intValue == 42)
        #expect(_ei(-7).exactIntegerValue.intValue == -7)
        #expect(_fp(7.0).exactIntegerValue.intValue == 7)
        #expect(_fr(8, 4).exactIntegerValue.intValue == 2)
    }

    @Test
    func test_floatingPointValue() {
        #expect(_ei(42).floatingPointValue.doubleValue == 42.0)
        #expect(_fp(3.14).floatingPointValue.doubleValue == 3.14)
        #expect(_fr(1, 2).floatingPointValue.doubleValue == 0.5)
    }

    @Test
    func test_inexact() {
        #expect(_ei(42).inexact.isInexact)
        #expect(_ei(42).inexact.isEqual(to: _fp(42.0)))
        #expect(_fp(3.14).inexact.isEqual(to: _fp(3.14)))
        #expect(_fr(1, 2).inexact.isInexact)
        #expect(_fr(1, 2).inexact.isEqual(to: _fp(0.5)))
    }

    @Test
    func test_isEven() {
        #expect(_ei(4).isEven)
        #expect(!_ei(3).isEven)
        #expect(_ei(0).isEven)
        #expect(_fp(4.0).isEven)
        #expect(!_fp(3.0).isEven)
        #expect(_fr(4, 1).isEven)
        #expect(!_fr(3, 1).isEven)
    }

    @Test
    func test_isExact() {
        #expect(_ei(42).isExact)
        #expect(!_fp(3.14).isExact)
        #expect(_fr(3, 4).isExact)
    }

    @Test
    func test_isFinite() {
        #expect(_ei(42).isFinite)
        #expect(_fp(3.14).isFinite)
        #expect(_fr(3, 4).isFinite)
        #expect(!Real.positiveInfinity.isFinite)
        #expect(!Real.negativeInfinity.isFinite)
        #expect(!Real.nan.isFinite)
    }

    @Test
    func test_isInexact() {
        #expect(!_ei(42).isInexact)
        #expect(_fp(3.14).isInexact)
        #expect(!_fr(3, 4).isInexact)
    }

    @Test
    func test_isInfinite() {
        #expect(!_ei(42).isInfinite)
        #expect(!_fp(3.14).isInfinite)
        #expect(!_fr(3, 4).isInfinite)
        #expect(Real.positiveInfinity.isInfinite)
        #expect(Real.negativeInfinity.isInfinite)
    }

    @Test
    func test_isInteger() {
        #expect(_ei(42).isInteger)
        #expect(_fp(3.0).isInteger)
        #expect(!_fp(3.14).isInteger)
        #expect(_fr(6, 3).isInteger)
        #expect(!_fr(3, 4).isInteger)
    }

    @Test
    func test_isNaN() {
        #expect(Real.nan.isNaN)
        #expect(!_ei(0).isNaN)
        #expect(!_fp(1.0).isNaN)
        #expect(!_fr(1, 2).isNaN)
    }

    @Test
    func test_isNegative() {
        #expect(_ei(-3).isNegative)
        #expect(!_ei(3).isNegative)
        #expect(!_ei(0).isNegative)
        #expect(_fp(-1.5).isNegative)
        #expect(!_fp(1.5).isNegative)
        #expect(_fr(-3, 4).isNegative)
        #expect(!_fr(3, 4).isNegative)
    }

    @Test
    func test_isOdd() {
        #expect(_ei(3).isOdd)
        #expect(!_ei(4).isOdd)
        #expect(_fp(3.0).isOdd)
        #expect(!_fp(4.0).isOdd)
        #expect(_fr(3, 1).isOdd)
        #expect(!_fr(4, 1).isOdd)
    }

    @Test
    func test_isPositive() {
        #expect(_ei(3).isPositive)
        #expect(!_ei(-3).isPositive)
        #expect(!_ei(0).isPositive)
        #expect(_fp(1.5).isPositive)
        #expect(!_fp(-1.5).isPositive)
        #expect(_fr(3, 4).isPositive)
        #expect(!_fr(-3, 4).isPositive)
    }

    @Test
    func test_isRational() {
        #expect(_ei(42).isRational)
        #expect(_fp(3.14).isRational)
        #expect(_fr(3, 4).isRational)
        #expect(!Real.nan.isRational)
        #expect(!Real.positiveInfinity.isRational)
        #expect(!Real.negativeInfinity.isRational)
    }

    @Test
    func test_isZero() {
        #expect(_ei(0).isZero)
        #expect(!_ei(42).isZero)
        #expect(Real.inexactZero.isZero)
        #expect(!_fp(1.0).isZero)
        #expect(_fr(0, 1).isZero)
        #expect(!_fr(3, 4).isZero)
    }

    @Test
    func test_numerator() {
        #expect(_ei(42).numerator.isEqual(to: _ei(42)))
        #expect(_fp(7.0).numerator.isEqual(to: _fp(7.0)))
        #expect(_fr(3, 4).numerator.isEqual(to: _ei(3)))
        #expect(_fr(-5, 7).numerator.isEqual(to: _ei(-5)))
    }

    @Test
    func test_simplified() {
        #expect(_ei(42).simplified.isEqual(to: _ei(42)))
        #expect(_fp(3.14).simplified.isEqual(to: _fp(3.14)))
        #expect(_fr(6, 3).simplified.isEqual(to: _ei(2)))
        #expect(_fr(3, 4).simplified.isEqual(to: _fr(3, 4)))
    }
}

// MARK: - Test internal instance methods

extension RealTests {
    @Test
    func test_absoluteValue() {
        #expect(_ei(-5).absoluteValue().isEqual(to: _ei(5)))
        #expect(_ei(5).absoluteValue().isEqual(to: _ei(5)))
        #expect(_ei(0).absoluteValue().isEqual(to: _ei(0)))
        #expect(_fp(-3.14).absoluteValue().isEqual(to: _fp(3.14)))
        #expect(_fp(3.14).absoluteValue().isEqual(to: _fp(3.14)))
        #expect(_fr(-3, 4).absoluteValue().isEqual(to: _fr(3, 4)))
        #expect(_fr(3, 4).absoluteValue().isEqual(to: _fr(3, 4)))
    }

    @Test
    func test_adding() {
        #expect(_ei(3).adding(_ei(4)).isEqual(to: _ei(7)))
        #expect(_fp(1.5).adding(_fp(2.5)).isEqual(to: _fp(4.0)))
        #expect(_fr(1, 4).adding(_fr(1, 4)).isEqual(to: _fr(1, 2)))
        #expect(_ei(1).adding(_fp(2.5)).isEqual(to: _fp(3.5)))
        #expect(_ei(1).adding(_fr(1, 2)).isEqual(to: _fr(3, 2)))
    }

    @Test
    func test_bitwiseAnd_with() {
        #expect(_ei(12).bitwiseAnd(with: _ei(10)).isEqual(to: _ei(8)))
        #expect(_ei(0xFF).bitwiseAnd(with: _ei(0x0F)).isEqual(to: _ei(0x0F)))
        #expect(_ei(0).bitwiseAnd(with: _ei(0xFF)).isEqual(to: _ei(0)))
        #expect(_fp(12.0).bitwiseAnd(with: _fp(10.0)).isEqual(to: _fp(8.0)))
    }

    @Test
    func test_bitwiseNot() {
        #expect(_ei(0).bitwiseNot().isEqual(to: _ei(-1)))
        #expect(_ei(-1).bitwiseNot().isEqual(to: _ei(0)))
        #expect(_ei(5).bitwiseNot().isEqual(to: _ei(-6)))
        #expect(_fp(0.0).bitwiseNot().isEqual(to: _fp(-1.0)))
    }

    @Test
    func test_bitwiseOr_with() {
        #expect(_ei(12).bitwiseOr(with: _ei(10)).isEqual(to: _ei(14)))
        #expect(_ei(0).bitwiseOr(with: _ei(0xFF)).isEqual(to: _ei(0xFF)))
        #expect(_fp(12.0).bitwiseOr(with: _fp(10.0)).isEqual(to: _fp(14.0)))
    }

    @Test
    func test_bitwiseShiftLeft_bits() {
        #expect(_ei(1).bitwiseShiftLeft(bits: 3).isEqual(to: _ei(8)))
        #expect(_ei(5).bitwiseShiftLeft(bits: 1).isEqual(to: _ei(10)))
        #expect(_fp(1.0).bitwiseShiftLeft(bits: 3).isEqual(to: _fp(8.0)))
    }

    @Test
    func test_bitwiseShiftRight_bits() {
        #expect(_ei(8).bitwiseShiftRight(bits: 3).isEqual(to: _ei(1)))
        #expect(_ei(10).bitwiseShiftRight(bits: 1).isEqual(to: _ei(5)))
        #expect(_fp(8.0).bitwiseShiftRight(bits: 3).isEqual(to: _fp(1.0)))
    }

    @Test
    func test_bitwiseXor_with() {
        #expect(_ei(12).bitwiseXor(with: _ei(10)).isEqual(to: _ei(6)))
        #expect(_ei(0xFF).bitwiseXor(with: _ei(0xFF)).isEqual(to: _ei(0)))
        #expect(_fp(12.0).bitwiseXor(with: _fp(10.0)).isEqual(to: _fp(6.0)))
    }

    @Test
    func test_ceiling() {
        #expect(_ei(3).ceiling().isEqual(to: _ei(3)))
        #expect(_fp(3.2).ceiling().isEqual(to: _fp(4.0)))
        #expect(_fp(-3.2).ceiling().isEqual(to: _fp(-3.0)))
        #expect(_fp(3.0).ceiling().isEqual(to: _fp(3.0)))
        #expect(_fr(7, 2).ceiling().isEqual(to: _ei(4)))
        #expect(_fr(-7, 2).ceiling().isEqual(to: _ei(-3)))
    }

    @Test
    func test_compare_to() {
        #expect(_ei(3).isLess(than: _ei(5)))
        #expect(!_ei(5).isLess(than: _ei(3)))
        #expect(!_ei(3).isLess(than: _ei(3)))
        #expect(_fp(1.5).isLess(than: _fp(2.5)))
        #expect(!_fp(2.5).isLess(than: _fp(1.5)))
        #expect(_fr(1, 4).isLess(than: _fr(1, 2)))
        #expect(!_fr(1, 2).isLess(than: _fr(1, 4)))
        #expect(_ei(1).isLess(than: _fp(1.5)))
        #expect(_ei(1).isLess(than: _fr(3, 2)))
    }

    @Test
    func test_cosine() {
        #expect(_ei(0).cosine().isEqual(to: _fp(1.0)))
        #expect(_fp(0.0).cosine().isEqual(to: _fp(1.0)))
        #expect(_fr(0, 1).cosine().isEqual(to: _fp(1.0)))
    }

    @Test
    func test_divided_by() {
        #expect(_ei(10).divided(by: _ei(2)).isEqual(to: _ei(5)))
        #expect(_ei(10).divided(by: _ei(3)).isEqual(to: _fr(10, 3)))
        #expect(_fp(10.0).divided(by: _fp(2.0)).isEqual(to: _fp(5.0)))
        #expect(_fr(3, 4).divided(by: _fr(1, 2)).isEqual(to: _fr(3, 2)))
    }

    @Test
    func test_exponential() {
        #expect(_ei(0).exponential().isEqual(to: _fp(1.0)))
        #expect(_fp(0.0).exponential().isEqual(to: _fp(1.0)))
        #expect(_fr(0, 1).exponential().isEqual(to: _fp(1.0)))
    }

    @Test
    func test_exponential_base() {
        #expect(_ei(0).exponential(base: _ei(2)).isEqual(to: _fp(1.0)))
        #expect(_fp(0.0).exponential(base: _fp(10.0)).isEqual(to: _fp(1.0)))
        #expect(_fr(0, 1).exponential(base: _ei(5)).isEqual(to: _fp(1.0)))
    }

    @Test
    func test_exponentialBase2() {
        #expect(_ei(0).exponentialBase2().isEqual(to: _fp(1.0)))
        #expect(_ei(3).exponentialBase2().isEqual(to: _fp(8.0)))
        #expect(_fp(0.0).exponentialBase2().isEqual(to: _fp(1.0)))
    }

    @Test
    func test_exponentialBase10() {
        #expect(_ei(0).exponentialBase10().isEqual(to: _fp(1.0)))
        #expect(_ei(2).exponentialBase10().isEqual(to: _fp(100.0)))
        #expect(_fp(0.0).exponentialBase10().isEqual(to: _fp(1.0)))
    }

    @Test
    func test_floor() {
        #expect(_ei(3).floor().isEqual(to: _ei(3)))
        #expect(_fp(3.7).floor().isEqual(to: _fp(3.0)))
        #expect(_fp(-3.7).floor().isEqual(to: _fp(-4.0)))
        #expect(_fp(3.0).floor().isEqual(to: _fp(3.0)))
        #expect(_fr(7, 2).floor().isEqual(to: _ei(3)))
        #expect(_fr(-7, 2).floor().isEqual(to: _ei(-4)))
    }

    @Test
    func test_greatestCommonDivisor_with() {
        #expect(_ei(12).greatestCommonDivisor(with: _ei(8)).isEqual(to: _ei(4)))
        #expect(_ei(7).greatestCommonDivisor(with: _ei(5)).isEqual(to: _ei(1)))
        #expect(_ei(0).greatestCommonDivisor(with: _ei(5)).isEqual(to: _ei(5)))
        #expect(_fp(12.0).greatestCommonDivisor(with: _fp(8.0)).isEqual(to: _fp(4.0)))
    }

    @Test
    func test_hyperbolicCosine() {
        #expect(_ei(0).hyperbolicCosine().isEqual(to: _fp(1.0)))
        #expect(_fp(0.0).hyperbolicCosine().isEqual(to: _fp(1.0)))
    }

    @Test
    func test_hyperbolicSine() {
        #expect(_ei(0).hyperbolicSine().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).hyperbolicSine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_hyperbolicTangent() {
        #expect(_ei(0).hyperbolicTangent().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).hyperbolicTangent().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_hypotenuse_with() {
        #expect(_ei(3).hypotenuse(with: _ei(4)).isEqual(to: _fp(5.0)))
        #expect(_fp(3.0).hypotenuse(with: _fp(4.0)).isEqual(to: _fp(5.0)))
        #expect(_ei(0).hypotenuse(with: _ei(5)).isEqual(to: _fp(5.0)))
    }

    @Test
    func test_inverseCosine() {
        #expect(_ei(1).inverseCosine().isEqual(to: _fp(0.0)))
        #expect(_fp(1.0).inverseCosine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseHyperbolicCosine() {
        #expect(_ei(1).inverseHyperbolicCosine().isEqual(to: _fp(0.0)))
        #expect(_fp(1.0).inverseHyperbolicCosine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseHyperbolicSine() {
        #expect(_ei(0).inverseHyperbolicSine().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).inverseHyperbolicSine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseHyperbolicTangent() {
        #expect(_ei(0).inverseHyperbolicTangent().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).inverseHyperbolicTangent().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseSine() {
        #expect(_ei(0).inverseSine().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).inverseSine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseTangent() {
        #expect(_ei(0).inverseTangent().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).inverseTangent().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_inverseTangent2() {
        #expect(_ei(0).inverseTangent(_ei(1)).isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).inverseTangent(_fp(1.0)).isEqual(to: _fp(0.0)))
    }

    @Test
    func test_isEqual_to() {
        #expect(_ei(42).isEqual(to: _ei(42)))
        #expect(!_ei(42).isEqual(to: _ei(43)))
        #expect(_fp(3.14).isEqual(to: _fp(3.14)))
        #expect(!_fp(3.14).isEqual(to: _fp(2.71)))
        #expect(_fr(1, 2).isEqual(to: _fr(1, 2)))
        #expect(!_fr(1, 2).isEqual(to: _fr(1, 3)))
        #expect(_ei(2).isEqual(to: _fp(2.0)))
        #expect(_ei(2).isEqual(to: _fr(4, 2)))
    }

    @Test
    func test_leastCommonMultiple_with() {
        #expect(_ei(4).leastCommonMultiple(with: _ei(6)).isEqual(to: _ei(12)))
        #expect(_ei(3).leastCommonMultiple(with: _ei(5)).isEqual(to: _ei(15)))
        #expect(_fp(4.0).leastCommonMultiple(with: _fp(6.0)).isEqual(to: _fp(12.0)))
    }

    @Test
    func test_logarithm() {
        #expect(_ei(1).logarithm().isEqual(to: _fp(0.0)))
        #expect(_fp(1.0).logarithm().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_logarithm_base() {
        #expect(_ei(1).logarithm(base: _ei(10)).isEqual(to: _fp(0.0)))
        #expect(_fp(1.0).logarithm(base: _fp(10.0)).isEqual(to: _fp(0.0)))
    }

    @Test
    func test_logarithmBase2() {
        #expect(_ei(1).logarithmBase2().isEqual(to: _fp(0.0)))
        #expect(_ei(8).logarithmBase2().isEqual(to: _fp(3.0)))
        #expect(_fp(1.0).logarithmBase2().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_logarithmBase10() {
        #expect(_ei(1).logarithmBase10().isEqual(to: _fp(0.0)))
        #expect(_ei(100).logarithmBase10().isEqual(to: _fp(2.0)))
        #expect(_fp(1.0).logarithmBase10().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_modulo() {
        #expect(_ei(7).modulo(_ei(3)).isEqual(to: _ei(1)))
        #expect(_ei(-7).modulo(_ei(3)).isEqual(to: _ei(2)))
        #expect(_ei(0).modulo(_ei(3)).isEqual(to: _ei(0)))
        #expect(_fp(7.0).modulo(_fp(3.0)).isEqual(to: _fp(1.0)))
    }

    @Test
    func test_multiplied_by() {
        #expect(_ei(3).multiplied(by: _ei(4)).isEqual(to: _ei(12)))
        #expect(_fp(2.5).multiplied(by: _fp(4.0)).isEqual(to: _fp(10.0)))
        #expect(_fr(2, 3).multiplied(by: _fr(3, 4)).isEqual(to: _fr(1, 2)))
        #expect(_ei(3).multiplied(by: _fp(2.0)).isEqual(to: _fp(6.0)))
    }

    @Test
    func test_negated() {
        #expect(_ei(5).negated().isEqual(to: _ei(-5)))
        #expect(_ei(-5).negated().isEqual(to: _ei(5)))
        #expect(_ei(0).negated().isEqual(to: _ei(0)))
        #expect(_fp(3.14).negated().isEqual(to: _fp(-3.14)))
        #expect(_fr(3, 4).negated().isEqual(to: _fr(-3, 4)))
    }

    @Test
    func test_quotient_dividingBy() {
        #expect(_ei(10).quotient(dividingBy: _ei(3)).isEqual(to: _ei(3)))
        #expect(_ei(-10).quotient(dividingBy: _ei(3)).isEqual(to: _ei(-3)))
        #expect(_fp(10.0).quotient(dividingBy: _fp(3.0)).isEqual(to: _fp(3.0)))
    }

    @Test
    func test_power() {
        #expect(_ei(0).exponential(base: _ei(2)).isEqual(to: _fp(1.0)))
        #expect(_fp(0.0).exponential(base: _fp(5.0)).isEqual(to: _fp(1.0)))
        #expect(_fr(0, 1).exponential(base: _ei(7)).isEqual(to: _fp(1.0)))
    }

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
    func test_remainder_dividingBy() {
        #expect(_ei(10).remainder(dividingBy: _ei(3)).isEqual(to: _ei(1)))
        #expect(_ei(-10).remainder(dividingBy: _ei(3)).isEqual(to: _ei(-1)))
        #expect(_ei(0).remainder(dividingBy: _ei(3)).isEqual(to: _ei(0)))
        #expect(_fp(10.0).remainder(dividingBy: _fp(3.0)).isEqual(to: _fp(1.0)))
    }

    @Test
    func test_round() {
        #expect(_ei(3).round().isEqual(to: _ei(3)))
        #expect(_fp(3.7).round().isEqual(to: _fp(4.0)))
        #expect(_fp(3.2).round().isEqual(to: _fp(3.0)))
        #expect(_fp(-3.7).round().isEqual(to: _fp(-4.0)))
        #expect(_fr(7, 3).round().isEqual(to: _ei(2)))
        #expect(_fr(-7, 3).round().isEqual(to: _ei(-2)))
    }

    @Test
    func test_sine() {
        #expect(_ei(0).sine().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).sine().isEqual(to: _fp(0.0)))
        #expect(_fr(0, 1).sine().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_squareRoot() {
        #expect(_ei(4).squareRoot().isEqual(to: _fp(2.0)))
        #expect(_fp(9.0).squareRoot().isEqual(to: _fp(3.0)))
        #expect(_ei(0).squareRoot().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_subtracting() {
        #expect(_ei(7).subtracting(_ei(3)).isEqual(to: _ei(4)))
        #expect(_fp(5.5).subtracting(_fp(2.5)).isEqual(to: _fp(3.0)))
        #expect(_fr(3, 4).subtracting(_fr(1, 4)).isEqual(to: _fr(1, 2)))
        #expect(_ei(5).subtracting(_fp(2.0)).isEqual(to: _fp(3.0)))
    }

    @Test
    func test_tangent() {
        #expect(_ei(0).tangent().isEqual(to: _fp(0.0)))
        #expect(_fp(0.0).tangent().isEqual(to: _fp(0.0)))
        #expect(_fr(0, 1).tangent().isEqual(to: _fp(0.0)))
    }

    @Test
    func test_truncate() {
        #expect(_ei(3).truncate().isEqual(to: _ei(3)))
        #expect(_fp(3.7).truncate().isEqual(to: _fp(3.0)))
        #expect(_fp(-3.7).truncate().isEqual(to: _fp(-3.0)))
        #expect(_fr(7, 2).truncate().isEqual(to: _ei(3)))
        #expect(_fr(-7, 2).truncate().isEqual(to: _ei(-3)))
    }
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
