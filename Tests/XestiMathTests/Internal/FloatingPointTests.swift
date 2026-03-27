// © 2025–2026 John Gary Pusey (see LICENSE.md)

import RealModule
import Testing
@testable import XestiMath

struct FloatingPointTests {
}

// MARK: - Test internal type methods

extension FloatingPointTests {
    @Test
    func test_parse() {
        #expect(FloatingPoint.parse(input: "3.14")?.testEqual(to: _fp(3.14)) == true)
        #expect(FloatingPoint.parse(input: "-2.5")?.testEqual(to: _fp(-2.5)) == true)
        #expect(FloatingPoint.parse(input: "0.0")?.isZero == true)
        #expect(FloatingPoint.parse(input: "1.0")?.testEqual(to: _fp(1.0)) == true)
        #expect(FloatingPoint.parse(input: "+inf.0")?.isInfinite == true)
        #expect(FloatingPoint.parse(input: "-inf.0")?.isInfinite == true)
        #expect(FloatingPoint.parse(input: "+nan.0")?.isNaN == true)
        #expect(FloatingPoint.parse(input: "-nan.0")?.isNaN == true)
        #expect(FloatingPoint.parse(input: "abc") == nil)
    }
}

// MARK: - Test internal initializers

extension FloatingPointTests {
    @Test
    func test_init_binaryFloatingPoint() {
        #expect(_fp(3.14).testEqual(to: _fp(3.14)))
        #expect(_fp(-2.5).testEqual(to: _fp(-2.5)))
        #expect(_fp(0.0).isZero)
        #expect(_fp(-0.0).isZero)
        #expect(_fp(Double.infinity).isInfinite)
        #expect(_fp(Double.nan).isNaN)
    }

    @Test
    func test_init_binaryInteger() {
        #expect(FloatingPoint(Int(42)).testEqual(to: _fp(42.0)))
        #expect(FloatingPoint(Int(-7)).testEqual(to: _fp(-7.0)))
        #expect(FloatingPoint(Int(0)).isZero)
    }
}

// MARK: - Test internal instance properties

extension FloatingPointTests {
    @Test
    func test_debugDescription() {
        #expect(String(reflecting: FloatingPoint.nan) == "floatingPoint<+nan.0>")
        #expect(String(reflecting: FloatingPoint.negativeInfinity) == "floatingPoint<-inf.0>")
        #expect(String(reflecting: FloatingPoint.one) == "floatingPoint<1.0>")
        #expect(String(reflecting: FloatingPoint.pi) == "floatingPoint<3.141592653589793>")
        #expect(String(reflecting: FloatingPoint.positiveInfinity) == "floatingPoint<+inf.0>")
        #expect(String(reflecting: FloatingPoint.zero) == "floatingPoint<0.0>")
        #expect(String(reflecting: _fp(-0.0)) == "floatingPoint<0.0>")
        #expect(String(reflecting: _fp(-Double.pi)) == "floatingPoint<-3.141592653589793>")
        #expect(String(reflecting: _fp(-1)) == "floatingPoint<-1.0>")
    }

    @Test
    func test_description() {
        #expect(String(describing: FloatingPoint.nan) == "+nan.0")
        #expect(String(describing: FloatingPoint.negativeInfinity) == "-inf.0")
        #expect(String(describing: FloatingPoint.one) == "1.0")
        #expect(String(describing: FloatingPoint.pi) == "3.141592653589793")
        #expect(String(describing: FloatingPoint.positiveInfinity) == "+inf.0")
        #expect(String(describing: FloatingPoint.zero) == "0.0")
        #expect(String(describing: _fp(-0.0)) == "0.0")
        #expect(String(describing: _fp(-Double.pi)) == "-3.141592653589793")
        #expect(String(describing: _fp(-1)) == "-1.0")
    }

    @Test
    func test_doubleValue() {
        #expect(FloatingPoint.one.doubleValue == 1.0)
        #expect(FloatingPoint.zero.doubleValue == 0.0)
        #expect(FloatingPoint.pi.doubleValue == Double.pi)
        #expect(_fp(-2.5).doubleValue == -2.5)
        #expect(FloatingPoint.nan.doubleValue.isNaN)
    }

    @Test
    func test_exactIntegerValue() {
        #expect(_fp(-0.0).exactIntegerValue.isEqual(to: _ei(0)))
        #expect(_fp(-1).exactIntegerValue.isEqual(to: _ei(-1)))
        #expect(FloatingPoint.one.exactIntegerValue.isEqual(to: _ei(1)))
        #expect(FloatingPoint.zero.exactIntegerValue.isEqual(to: _ei(0)))
    }

    @Test
    func test_floatValue() {
        #expect(FloatingPoint.one.floatValue == 1.0)
        #expect(FloatingPoint.zero.floatValue == 0.0)
        #expect(_fp(-2.5).floatValue == -2.5)
        #expect(FloatingPoint.nan.floatValue.isNaN)
    }

    @Test
    func test_fractionValue() {
        #expect(_fp(-1.75).fractionValue.isEqual(to: _fr(-7, 4)))
        #expect(_fp(1.03125).fractionValue.isEqual(to: _fr(33, 32)))
        #expect(_fp(5.0 / 17.0).fractionValue.isEqual(to: _fr(5, 17)))
        #expect(FloatingPoint.pi.fractionValue.isEqual(to: _fr(355, 113)))
        #expect(FloatingPoint.zero.fractionValue.isEqual(to: _fr(0, 1)))
    }

    @Test
    func test_isFinite() {
        #expect(!FloatingPoint.nan.isFinite)
        #expect(!FloatingPoint.negativeInfinity.isFinite)
        #expect(FloatingPoint.one.isFinite)
        #expect(FloatingPoint.pi.isFinite)
        #expect(!FloatingPoint.positiveInfinity.isFinite)
        #expect(FloatingPoint.zero.isFinite)
    }

    @Test
    func test_isInfinite() {
        #expect(!FloatingPoint.nan.isInfinite)
        #expect(FloatingPoint.negativeInfinity.isInfinite)
        #expect(!FloatingPoint.one.isInfinite)
        #expect(!FloatingPoint.pi.isInfinite)
        #expect(FloatingPoint.positiveInfinity.isInfinite)
        #expect(!FloatingPoint.zero.isInfinite)
    }

    @Test
    func test_isInteger() {
        #expect(!FloatingPoint.nan.isInteger)
        #expect(!FloatingPoint.negativeInfinity.isInteger)
        #expect(FloatingPoint.one.isInteger)
        #expect(!FloatingPoint.pi.isInteger)
        #expect(!FloatingPoint.positiveInfinity.isInteger)
        #expect(FloatingPoint.zero.isInteger)
    }

    @Test
    func test_isNaN() {
        #expect(FloatingPoint.nan.isNaN)
        #expect(!FloatingPoint.negativeInfinity.isNaN)
        #expect(!FloatingPoint.one.isNaN)
        #expect(!FloatingPoint.pi.isNaN)
        #expect(!FloatingPoint.positiveInfinity.isNaN)
        #expect(!FloatingPoint.zero.isNaN)
    }

    @Test
    func test_isNegative() {
        #expect(!FloatingPoint.nan.isNegative)
        #expect(FloatingPoint.negativeInfinity.isNegative)
        #expect(!FloatingPoint.one.isNegative)
        #expect(!FloatingPoint.pi.isNegative)
        #expect(!FloatingPoint.positiveInfinity.isNegative)
        #expect(!FloatingPoint.zero.isNegative)
        #expect(!_fp(-0.0).isNegative)
        #expect(_fp(-Double.pi).isNegative)
        #expect(_fp(-1).isNegative)
    }

    @Test
    func test_isPositive() {
        #expect(!FloatingPoint.nan.isPositive)
        #expect(!FloatingPoint.negativeInfinity.isPositive)
        #expect(FloatingPoint.one.isPositive)
        #expect(FloatingPoint.pi.isPositive)
        #expect(FloatingPoint.positiveInfinity.isPositive)
        #expect(!FloatingPoint.zero.isPositive)
        #expect(!_fp(-0.0).isPositive)
        #expect(!_fp(-Double.pi).isPositive)
        #expect(!_fp(-1).isPositive)
    }

    @Test
    func test_isZero() {
        #expect(!FloatingPoint.nan.isZero)
        #expect(!FloatingPoint.negativeInfinity.isZero)
        #expect(!FloatingPoint.one.isZero)
        #expect(!FloatingPoint.pi.isZero)
        #expect(!FloatingPoint.positiveInfinity.isZero)
        #expect(FloatingPoint.zero.isZero)
        #expect(_fp(-0.0).isZero)
        #expect(!_fp(-Double.pi).isZero)
        #expect(!_fp(-1).isZero)
    }
}

// MARK: - Test internal instance methods

extension FloatingPointTests {
    @Test
    func test_adding() {
        #expect(_fp(3.0).adding(_fp(4.0)).testEqual(to: _fp(7.0)))
        #expect(_fp(-1.5).adding(_fp(2.5)).testEqual(to: _fp(1.0)))
        #expect(FloatingPoint.zero.adding(_fp(5.0)).testEqual(to: _fp(5.0)))
        #expect(_fp(-3.0).adding(_fp(-4.0)).testEqual(to: _fp(-7.0)))
    }

    @Test
    func test_ceiling() {
        #expect(_fp(3.2).ceiling().testEqual(to: _fp(4.0)))
        #expect(_fp(-3.7).ceiling().testEqual(to: _fp(-3.0)))
        #expect(_fp(3.0).ceiling().testEqual(to: _fp(3.0)))
        #expect(_fp(-0.5).ceiling().isZero)
    }

    @Test
    func test_compare_to() {
        #expect(_fp(1.0).isLess(than: _fp(2.0)))
        #expect(!_fp(2.0).isLess(than: _fp(1.0)))
        #expect(!_fp(1.0).isLess(than: _fp(1.0)))
        #expect(_fp(-1.0).isLess(than: _fp(0.0)))
        #expect(FloatingPoint.negativeInfinity.isLess(than: _fp(0.0)))
        #expect(!FloatingPoint.nan.isLess(than: _fp(0.0)))
    }

    @Test
    func test_cosine() {
        #expect(FloatingPoint.zero.cosine().testEqual(to: _fp(1.0)))
        #expect(FloatingPoint.pi.cosine().testEqual(to: _fp(-1.0)))
        #expect(_fp(Double.pi / 3).cosine().testEqual(to: _fp(Double.cos(Double.pi / 3))))
    }

    @Test
    func test_divided_by() {
        #expect(_fp(10.0).divided(by: _fp(2.0)).testEqual(to: _fp(5.0)))
        #expect(_fp(-6.0).divided(by: _fp(3.0)).testEqual(to: _fp(-2.0)))
        #expect(_fp(1.0).divided(by: _fp(0.0)).isInfinite)
        #expect(_fp(0.0).divided(by: _fp(0.0)).isNaN)
    }

    @Test
    func test_exponential() {
        #expect(FloatingPoint.zero.exponential().testEqual(to: _fp(1.0)))
        #expect(FloatingPoint.one.exponential().testEqual(to: _fp(Double.exp(1.0))))
        #expect(_fp(2.0).exponential().testEqual(to: _fp(Double.exp(2.0))))
    }

    @Test
    func test_exponential_base() {
        #expect(_fp(3.0).exponential(base: _fp(2.0)).testEqual(to: _fp(8.0)))
        #expect(_fp(0.0).exponential(base: _fp(5.0)).testEqual(to: _fp(1.0)))
        #expect(_fp(2.0).exponential(base: _fp(10.0)).testEqual(to: _fp(100.0)))
    }

    @Test
    func test_exponentialBase2() {
        #expect(_fp(3.0).exponentialBase2().testEqual(to: _fp(8.0)))
        #expect(_fp(0.0).exponentialBase2().testEqual(to: _fp(1.0)))
        #expect(_fp(10.0).exponentialBase2().testEqual(to: _fp(1_024.0)))
    }

    @Test
    func test_exponentialBase10() {
        #expect(_fp(2.0).exponentialBase10().testEqual(to: _fp(100.0)))
        #expect(_fp(0.0).exponentialBase10().testEqual(to: _fp(1.0)))
        #expect(_fp(3.0).exponentialBase10().testEqual(to: _fp(1_000.0)))
    }

    @Test
    func test_floor() {
        #expect(_fp(3.7).floor().testEqual(to: _fp(3.0)))
        #expect(_fp(-3.2).floor().testEqual(to: _fp(-4.0)))
        #expect(_fp(3.0).floor().testEqual(to: _fp(3.0)))
    }

    @Test
    func test_hyperbolicCosine() {
        #expect(FloatingPoint.zero.hyperbolicCosine().testEqual(to: _fp(1.0)))
        #expect(_fp(1.0).hyperbolicCosine().testEqual(to: _fp(Double.cosh(1.0))))
        #expect(_fp(-1.0).hyperbolicCosine().testEqual(to: _fp(Double.cosh(-1.0))))
    }

    @Test
    func test_hyperbolicSine() {
        #expect(FloatingPoint.zero.hyperbolicSine().testEqual(to: _fp(0.0)))
        #expect(_fp(1.0).hyperbolicSine().testEqual(to: _fp(Double.sinh(1.0))))
        #expect(_fp(-1.0).hyperbolicSine().testEqual(to: _fp(Double.sinh(-1.0))))
    }

    @Test
    func test_hyperbolicTangent() {
        #expect(FloatingPoint.zero.hyperbolicTangent().testEqual(to: _fp(0.0)))
        #expect(_fp(1.0).hyperbolicTangent().testEqual(to: _fp(Double.tanh(1.0))))
        #expect(_fp(-1.0).hyperbolicTangent().testEqual(to: _fp(Double.tanh(-1.0))))
    }

    @Test
    func test_hypotenuse_with() {
        #expect(_fp(3.0).hypotenuse(with: _fp(4.0)).testEqual(to: _fp(5.0)))
        #expect(_fp(0.0).hypotenuse(with: _fp(5.0)).testEqual(to: _fp(5.0)))
        #expect(_fp(1.0).hypotenuse(with: _fp(1.0)).testEqual(to: _fp(Double.sqrt(2.0))))
    }

    @Test
    func test_inverseCosine() {
        #expect(_fp(-0.5).inverseCosine().testEqual(to: _fp(Double.acos(-0.5))))
        #expect(_fp(-0.7071).inverseCosine().testEqual(to: _fp(Double.acos(-0.7071))))
        #expect(_fp(-0.99).inverseCosine().testEqual(to: _fp(Double.acos(-0.99))))
        #expect(_fp(-1).inverseCosine().testEqual(to: _fp(Double.acos(-1))))
        #expect(_fp(0.5).inverseCosine().testEqual(to: _fp(Double.acos(0.5))))
        #expect(_fp(0.7071).inverseCosine().testEqual(to: _fp(Double.acos(0.7071))))
        #expect(_fp(0.99).inverseCosine().testEqual(to: _fp(Double.acos(0.99))))
        #expect(_fp(0).inverseCosine().testEqual(to: _fp(Double.acos(0))))
        #expect(_fp(1).inverseCosine().testEqual(to: _fp(Double.acos(1))))
        #expect(_fp(2).inverseCosine().isNaN)
    }

    @Test
    func test_inverseHyperbolicCosine() {
        #expect(_fp(1.0).inverseHyperbolicCosine().testEqual(to: _fp(0.0)))
        #expect(_fp(2.0).inverseHyperbolicCosine().testEqual(to: _fp(Double.acosh(2.0))))
        #expect(_fp(10.0).inverseHyperbolicCosine().testEqual(to: _fp(Double.acosh(10.0))))
        #expect(_fp(0.5).inverseHyperbolicCosine().isNaN)
    }

    @Test
    func test_inverseHyperbolicSine() {
        #expect(FloatingPoint.zero.inverseHyperbolicSine().testEqual(to: _fp(0.0)))
        #expect(_fp(1.0).inverseHyperbolicSine().testEqual(to: _fp(Double.asinh(1.0))))
        #expect(_fp(-1.0).inverseHyperbolicSine().testEqual(to: _fp(Double.asinh(-1.0))))
    }

    @Test
    func test_inverseHyperbolicTangent() {
        #expect(FloatingPoint.zero.inverseHyperbolicTangent().testEqual(to: _fp(0.0)))
        #expect(_fp(0.5).inverseHyperbolicTangent().testEqual(to: _fp(Double.atanh(0.5))))
        #expect(_fp(-0.5).inverseHyperbolicTangent().testEqual(to: _fp(Double.atanh(-0.5))))
    }

    @Test
    func test_inverseSine() {
        #expect(_fp(-0.5).inverseSine().testEqual(to: _fp(Double.asin(-0.5))))
        #expect(_fp(-0.7071).inverseSine().testEqual(to: _fp(Double.asin(-0.7071))))
        #expect(_fp(-0.99).inverseSine().testEqual(to: _fp(Double.asin(-0.99))))
        #expect(_fp(-1).inverseSine().testEqual(to: _fp(Double.asin(-1))))
        #expect(_fp(0.5).inverseSine().testEqual(to: _fp(Double.asin(0.5))))
        #expect(_fp(0.7071).inverseSine().testEqual(to: _fp(Double.asin(0.7071))))
        #expect(_fp(0.99).inverseSine().testEqual(to: _fp(Double.asin(0.99))))
        #expect(_fp(0).inverseSine().testEqual(to: _fp(Double.asin(0))))
        #expect(_fp(1).inverseSine().testEqual(to: _fp(Double.asin(1))))
        #expect(_fp(2).inverseSine().isNaN)
    }

    @Test
    func test_inverseTangent() {
        #expect(_fp(-0.5).inverseTangent().testEqual(to: _fp(Double.atan(-0.5))))
        #expect(_fp(-1).inverseTangent().testEqual(to: _fp(Double.atan(-1))))
        #expect(_fp(-10).inverseTangent().testEqual(to: _fp(Double.atan(-10))))
        #expect(_fp(-2).inverseTangent().testEqual(to: _fp(Double.atan(-2))))
        #expect(_fp(0.5).inverseTangent().testEqual(to: _fp(Double.atan(0.5))))
        #expect(_fp(0).inverseTangent().testEqual(to: _fp(Double.atan(0))))
        #expect(_fp(1).inverseTangent().testEqual(to: _fp(Double.atan(1))))
        #expect(_fp(10).inverseTangent().testEqual(to: _fp(Double.atan(10))))
        #expect(_fp(100).inverseTangent().testEqual(to: _fp(Double.atan(100))))
        #expect(_fp(2).inverseTangent().testEqual(to: _fp(Double.atan(2))))
    }

    @Test
    func test_inverseTangent2() {
        #expect(_fp(1.0).inverseTangent(_fp(1.0)).testEqual(to: _fp(Double.atan2(y: 1.0, x: 1.0))))
        #expect(_fp(0.0).inverseTangent(_fp(1.0)).testEqual(to: _fp(0.0)))
        #expect(_fp(1.0).inverseTangent(_fp(0.0)).testEqual(to: _fp(Double.pi / 2)))
        let atan2val = Double.atan2(y: -1.0, x: -1.0)
        #expect(_fp(-1.0).inverseTangent(_fp(-1.0)).testEqual(to: _fp(atan2val)))
    }

    @Test
    func test_isEqual_to() {
        #expect(FloatingPoint.one.isEqual(to: _fp(1.0)))
        #expect(!FloatingPoint.one.isEqual(to: _fp(2.0)))
        #expect(FloatingPoint.zero.isEqual(to: _fp(0.0)))
        #expect(!FloatingPoint.nan.isEqual(to: FloatingPoint.nan))
    }

    @Test
    func test_logarithm() {
        #expect(FloatingPoint.one.logarithm().testEqual(to: _fp(0.0)))
        #expect(_fp(Double.exp(1.0)).logarithm().testEqual(to: _fp(1.0)))
        #expect(_fp(Double.exp(2.0)).logarithm().testEqual(to: _fp(2.0)))
        #expect(_fp(-1.0).logarithm().isNaN)
    }

    @Test
    func test_logarithm_base() {
        #expect(_fp(8.0).logarithm(base: _fp(2.0)).testEqual(to: _fp(3.0)))
        #expect(_fp(100.0).logarithm(base: _fp(10.0)).testEqual(to: _fp(2.0)))
        #expect(_fp(1.0).logarithm(base: _fp(5.0)).testEqual(to: _fp(0.0)))
    }

    @Test
    func test_logarithmBase2() {
        #expect(_fp(8.0).logarithmBase2().testEqual(to: _fp(3.0)))
        #expect(_fp(1.0).logarithmBase2().testEqual(to: _fp(0.0)))
        #expect(_fp(1_024.0).logarithmBase2().testEqual(to: _fp(10.0)))
    }

    @Test
    func test_logarithmBase10() {
        #expect(_fp(100.0).logarithmBase10().testEqual(to: _fp(2.0)))
        #expect(_fp(1.0).logarithmBase10().testEqual(to: _fp(0.0)))
        #expect(_fp(1_000.0).logarithmBase10().testEqual(to: _fp(3.0)))
    }

    @Test
    func test_multiplied_by() {
        #expect(_fp(3.0).multiplied(by: _fp(4.0)).testEqual(to: _fp(12.0)))
        #expect(_fp(-2.0).multiplied(by: _fp(3.0)).testEqual(to: _fp(-6.0)))
        #expect(FloatingPoint.zero.multiplied(by: _fp(42.0)).isZero)
    }

    @Test
    func test_negated() {
        #expect(FloatingPoint.one.negated().testEqual(to: _fp(-1.0)))
        #expect(_fp(-3.5).negated().testEqual(to: _fp(3.5)))
        #expect(FloatingPoint.zero.negated().isZero)
    }

    @Test
    func test_power() {
        #expect(_fp(2.0).exponential(base: _fp(3.0)).testEqual(to: _fp(9.0)))
        #expect(_fp(0.5).exponential(base: _fp(4.0)).testEqual(to: _fp(2.0)))
        #expect(_fp(-1.0).exponential(base: _fp(2.0)).testEqual(to: _fp(0.5)))
        #expect(_fp(0.0).exponential(base: _fp(7.0)).testEqual(to: _fp(1.0)))
    }

    @Test
    func test_round() {
        #expect(_fp(3.3).round().testEqual(to: _fp(3.0)))
        #expect(_fp(3.7).round().testEqual(to: _fp(4.0)))
        #expect(_fp(-3.5).round().testEqual(to: _fp(-4.0)))
        #expect(_fp(3.5).round().testEqual(to: _fp(4.0)))
    }

    @Test
    func test_sine() {
        #expect(FloatingPoint.zero.sine().testEqual(to: _fp(0.0)))
        #expect(_fp(Double.pi / 2).sine().testEqual(to: _fp(1.0)))
        #expect(_fp(Double.pi / 6).sine().testEqual(to: _fp(Double.sin(Double.pi / 6))))
    }

    @Test
    func test_squareRoot() {
        #expect(_fp(4.0).squareRoot().testEqual(to: _fp(2.0)))
        #expect(_fp(9.0).squareRoot().testEqual(to: _fp(3.0)))
        #expect(FloatingPoint.zero.squareRoot().isZero)
        #expect(_fp(-1.0).squareRoot().isNaN)
    }

    @Test
    func test_subtracting() {
        #expect(_fp(7.0).subtracting(_fp(3.0)).testEqual(to: _fp(4.0)))
        #expect(_fp(3.0).subtracting(_fp(7.0)).testEqual(to: _fp(-4.0)))
        #expect(FloatingPoint.zero.subtracting(FloatingPoint.zero).isZero)
    }

    @Test
    func test_tangent() {
        #expect(FloatingPoint.zero.tangent().testEqual(to: _fp(0.0)))
        #expect(_fp(Double.pi / 4).tangent().testEqual(to: _fp(Double.tan(Double.pi / 4))))
        #expect(_fp(-Double.pi / 4).tangent().testEqual(to: _fp(Double.tan(-Double.pi / 4))))
    }

    @Test
    func test_truncate() {
        #expect(_fp(3.7).truncate().testEqual(to: _fp(3.0)))
        #expect(_fp(-3.7).truncate().testEqual(to: _fp(-3.0)))
        #expect(_fp(3.0).truncate().testEqual(to: _fp(3.0)))
    }
}

// MARK: -

extension FloatingPointTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }

    private func _fp<T: BinaryFloatingPoint>(_ val: T) -> FloatingPoint {
        FloatingPoint(val)
    }

    private func _fr<T: BinaryInteger>(_ num: T,
                                       _ den: T) -> Fraction {
        Fraction(numerator: _ei(num),
                 denominator: _ei(den))
    }
}

// MARK: -

extension FloatingPoint {
    internal func testEqual(to other: Self) -> Bool {
        doubleValue.isApproximatelyEqual(to: other.doubleValue)
    }
}
