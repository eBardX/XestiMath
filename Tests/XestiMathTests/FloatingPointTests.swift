// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct FloatingPointTests {
}

// MARK: - Test internal type methods

extension FloatingPointTests {
    @Test
    func parse() {}
}

// MARK: - Test internal initializers

extension FloatingPointTests {
    @Test
    func init_binaryFloatingPoint() {}

    @Test
    func init_binaryInteger() {}
}

// MARK: - Test internal instance properties

extension FloatingPointTests {
    @Test
    func debugDescription() {
        #expect(FloatingPoint.nan.debugDescription == "floatingPoint<+nan.0>")
        #expect(FloatingPoint.negativeInfinity.debugDescription == "floatingPoint<-inf.0>")
        #expect(FloatingPoint.one.debugDescription == "floatingPoint<1.0>")
        #expect(FloatingPoint.pi.debugDescription == "floatingPoint<3.141592653589793>")
        #expect(FloatingPoint.positiveInfinity.debugDescription == "floatingPoint<+inf.0>")
        #expect(FloatingPoint.zero.debugDescription == "floatingPoint<0.0>")
        #expect(_fp(-0.0).debugDescription == "floatingPoint<0.0>")
        #expect(_fp(-Double.pi).debugDescription == "floatingPoint<-3.141592653589793>")
        #expect(_fp(-1).debugDescription == "floatingPoint<-1.0>")
    }

    @Test
    func description() {
        #expect(FloatingPoint.nan.description == "+nan.0")
        #expect(FloatingPoint.negativeInfinity.description == "-inf.0")
        #expect(FloatingPoint.one.description == "1.0")
        #expect(FloatingPoint.pi.description == "3.141592653589793")
        #expect(FloatingPoint.positiveInfinity.description == "+inf.0")
        #expect(FloatingPoint.zero.description == "0.0")
        #expect(_fp(-0.0).description == "0.0")
        #expect(_fp(-Double.pi).description == "-3.141592653589793")
        #expect(_fp(-1).description == "-1.0")
    }

    @Test
    func doubleValue() {
    }

    @Test
    func exactIntegerValue() {
        #expect(FloatingPoint.nan.exactIntegerValue == nil)
        #expect(FloatingPoint.negativeInfinity.exactIntegerValue == nil)
        #expect(FloatingPoint.one.exactIntegerValue!.isEqual(to: _ei(1)))   // swiftlint:disable:this force_unwrapping
        #expect(FloatingPoint.pi.exactIntegerValue == nil)
        #expect(FloatingPoint.positiveInfinity.exactIntegerValue == nil)
        #expect(FloatingPoint.zero.exactIntegerValue!.isEqual(to: _ei(0)))  // swiftlint:disable:this force_unwrapping
        #expect(_fp(-0.0).exactIntegerValue!.isEqual(to: _ei(0)))           // swiftlint:disable:this force_unwrapping
        #expect(_fp(-Double.pi).exactIntegerValue == nil)
        #expect(_fp(-1).exactIntegerValue!.isEqual(to: _ei(-1)))            // swiftlint:disable:this force_unwrapping
    }

    @Test
    func floatValue() {
    }

    @Test
    func isFinite() {
        #expect(!FloatingPoint.nan.isFinite)
        #expect(!FloatingPoint.negativeInfinity.isFinite)
        #expect(FloatingPoint.one.isFinite)
        #expect(FloatingPoint.pi.isFinite)
        #expect(!FloatingPoint.positiveInfinity.isFinite)
        #expect(FloatingPoint.zero.isFinite)
    }

    @Test
    func isInfinite() {
        #expect(!FloatingPoint.nan.isInfinite)
        #expect(FloatingPoint.negativeInfinity.isInfinite)
        #expect(!FloatingPoint.one.isInfinite)
        #expect(!FloatingPoint.pi.isInfinite)
        #expect(FloatingPoint.positiveInfinity.isInfinite)
        #expect(!FloatingPoint.zero.isInfinite)
    }

    @Test
    func isInteger() {
        #expect(!FloatingPoint.nan.isInteger)
        #expect(!FloatingPoint.negativeInfinity.isInteger)
        #expect(FloatingPoint.one.isInteger)
        #expect(!FloatingPoint.pi.isInteger)
        #expect(!FloatingPoint.positiveInfinity.isInteger)
        #expect(FloatingPoint.zero.isInteger)
    }

    @Test
    func isNaN() {
        #expect(FloatingPoint.nan.isNaN)
        #expect(!FloatingPoint.negativeInfinity.isNaN)
        #expect(!FloatingPoint.one.isNaN)
        #expect(!FloatingPoint.pi.isNaN)
        #expect(!FloatingPoint.positiveInfinity.isNaN)
        #expect(!FloatingPoint.zero.isNaN)
    }

    @Test
    func isNegative() {
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
    func isPositive() {
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
    func isZero() {
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
    func adding() {}

    @Test
    func ceiling() {}

    @Test
    func cosine() {}

    @Test
    func divided_by() {}

    @Test
    func exponential() {}

    @Test
    func exponential_base() {}

    @Test
    func exponentialBase2() {}

    @Test
    func exponentialBase10() {}

    @Test
    func floor() {}

    @Test
    func hyperbolicCosine() {}

    @Test
    func hyperbolicSine() {}

    @Test
    func hyperbolicTangent() {}

    @Test
    func hypotenuse_with() {}

    @Test
    func inverseCosine() {
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
    func inverseHyperbolicCosine() {}

    @Test
    func inverseHyperbolicSine() {}

    @Test
    func inverseHyberbolicTangent() {}

    @Test
    func inverseSine() {
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
    func inverseTangent() {
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
    func inverseTangent2() {}

    @Test
    func isEqual_to() {}

    @Test
    func isLess_than() {}

    @Test
    func logarithm() {}

    @Test
    func logarithm_base() {}

    @Test
    func logarithmBase2() {}

    @Test
    func logarithmBase10() {}

    @Test
    func multiplied_by() {}

    @Test
    func negated() {}

    @Test
    func power() {}

    @Test
    func round() {}

    @Test
    func sine() {}

    @Test
    func squareRoot() {}

    @Test
    func subtracting() {}

    @Test
    func tangent() {}

    @Test
    func truncate() {}
}

// MARK: -

extension FloatingPointTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }

    private func _fp<T: BinaryFloatingPoint>(_ val: T) -> FloatingPoint {
        FloatingPoint(val)
    }
}

// MARK: -

extension FloatingPoint {
    internal func testEqual(to other: Self) -> Bool {
        doubleValue.isApproximatelyEqual(to: other.doubleValue)
    }
}
