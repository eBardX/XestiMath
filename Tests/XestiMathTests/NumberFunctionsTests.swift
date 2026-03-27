// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiMath

struct NumberFunctionsTests {
}

// MARK: -

extension NumberFunctionsTests {
    @Test
    func test_abs() {
        #expect(XestiMath.abs(Number(5)) == Number(5))
        #expect(XestiMath.abs(Number(-5)) == Number(5))
        #expect(XestiMath.abs(Number(0)) == Number(0))
    }

    @Test
    func test_acos() {
        let result = XestiMath.acos(Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_asin() {
        let result = XestiMath.asin(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_atan() {
        let result = XestiMath.atan(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_atan2() {
        let result = XestiMath.atan(Number(1.0), Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: Double.pi / 4))
    }

    @Test
    func test_ceiling() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiMath.ceiling(fraction) == Number(4))

        let floatVal = Number(3.2)

        #expect(XestiMath.ceiling(floatVal).doubleValue.isApproximatelyEqual(to: 4.0))

        #expect(XestiMath.ceiling(Number(5)) == Number(5))
    }

    @Test
    func test_cos() {
        let result = XestiMath.cos(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 1.0))
    }

    @Test
    func test_exp() {
        let result0 = XestiMath.exp(Number(0.0))

        #expect(result0.doubleValue.isApproximatelyEqual(to: 1.0))

        let result1 = XestiMath.exp(Number(1.0))

        #expect(result1.doubleValue.isApproximatelyEqual(to: Foundation.exp(1.0)))
    }

    @Test
    func test_floor() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiMath.floor(fraction) == Number(3))

        let floatVal = Number(3.8)

        #expect(XestiMath.floor(floatVal).doubleValue.isApproximatelyEqual(to: 3.0))

        #expect(XestiMath.floor(Number(5)) == Number(5))
    }

    @Test
    func test_gcd() {
        #expect(XestiMath.gcd(Number(12), Number(8)) == Number(4))
        #expect(XestiMath.gcd(Number(15), Number(10)) == Number(5))
        #expect(XestiMath.gcd(Number(7), Number(3)) == Number(1))
    }

    @Test
    func test_lcm() {
        #expect(XestiMath.lcm(Number(4), Number(6)) == Number(12))
        #expect(XestiMath.lcm(Number(3), Number(5)) == Number(15))
    }

    @Test
    func test_log() {
        let result = XestiMath.log(Number(1.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_max() {
        #expect(XestiMath.max(Number(3), Number(5)) == Number(5))
        #expect(XestiMath.max(Number(5), Number(3)) == Number(5))
        #expect(XestiMath.max(Number(4), Number(4)) == Number(4))
    }

    @Test
    func test_min() {
        #expect(XestiMath.min(Number(3), Number(5)) == Number(3))
        #expect(XestiMath.min(Number(5), Number(3)) == Number(3))
        #expect(XestiMath.min(Number(4), Number(4)) == Number(4))
    }

    @Test
    func test_modulo() {
        #expect(XestiMath.modulo(Number(13), Number(4)) == Number(1))
        #expect(XestiMath.modulo(Number(-13), Number(4)) == Number(3))
        #expect(XestiMath.modulo(Number(13), Number(-4)) == Number(-3))
        #expect(XestiMath.modulo(Number(-13), Number(-4)) == Number(-1))
    }

    @Test
    func test_quotient() {
        #expect(XestiMath.quotient(Number(7), Number(2)) == Number(3))
        #expect(XestiMath.quotient(Number(10), Number(3)) == Number(3))
    }

    @Test
    func test_remainder() {
        #expect(XestiMath.remainder(Number(7), Number(2)) == Number(1))
        #expect(XestiMath.remainder(Number(-7), Number(2)) == Number(-1))
        #expect(XestiMath.remainder(Number(7), Number(-2)) == Number(1))
    }

    @Test
    func test_round() {
        let result = XestiMath.round(Number(numerator: 7, denominator: 2))

        #expect(result == Number(4))

        #expect(XestiMath.round(Number(numerator: 5, denominator: 2)) == Number(2))
    }

    @Test
    func test_sin() {
        let result = XestiMath.sin(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_sqrt() {
        #expect(XestiMath.sqrt(Number(4.0)).doubleValue.isApproximatelyEqual(to: 2.0))
        #expect(XestiMath.sqrt(Number(9.0)).doubleValue.isApproximatelyEqual(to: 3.0))
        #expect(XestiMath.sqrt(Number(0.0)).doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_tan() {
        let result = XestiMath.tan(Number(0.0))

        #expect(result.doubleValue.isApproximatelyEqual(to: 0.0))
    }

    @Test
    func test_truncate() {
        let fraction = Number(numerator: 7, denominator: 2)

        #expect(XestiMath.truncate(fraction) == Number(3))

        let negative = Number(numerator: -7, denominator: 2)

        #expect(XestiMath.truncate(negative) == Number(-3))
    }
}

// MARK: -

private extension Double {
    func isApproximatelyEqual(to other: Double,
                              tolerance: Double = 1e-10) -> Bool {
        Swift.abs(self - other) < tolerance
    }
}
