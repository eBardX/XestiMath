// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct ExactIntegerTests {
}

// MARK: - Test internal type methods

extension ExactIntegerTests {
    @Test
    func parse_radix() {}
}

// MARK: - Test internal initializers

extension ExactIntegerTests {
    @Test
    func init_binaryFloatingPoint() {}

    @Test
    func init_binaryInteger() {}
}

// MARK: - Test internal instance properties

extension ExactIntegerTests {
    @Test
    func debugDescription() {}

    @Test
    func description() {}

    @Test
    func floatingPointValue() {}

    @Test
    func int16Value() {}

    @Test
    func int32Value() {}

    @Test
    func int64Value() {}

    @Test
    func int8Value() {}

    @Test
    func intValue() {}

    @Test
    func isEven() {}

    @Test
    func isNegative() {}

    @Test
    func isOdd() {}

    @Test
    func isPositive() {}

    @Test
    func isZero() {}

    @Test
    func uint16Value() {}

    @Test
    func uint32Value() {}

    @Test
    func uint64Value() {}

    @Test
    func uint8Value() {}

    @Test
    func uintValue() {}
}

// MARK: - Test internal instance methods

extension ExactIntegerTests {
    @Test
    func adding() {}

    @Test
    func bitwiseAnd_with() {}

    @Test
    func bitwiseNot() {}

    @Test
    func bitwiseOr_with() {}

    @Test
    func bitwiseShiftLeft_bits() {}

    @Test
    func bitwiseShiftRight_bits() {}

    @Test
    func bitwiseXor_with() {}

    @Test
    func greatestCommonDivisor_with() {
        #expect(_ei(32).greatestCommonDivisor(with: _ei(-36)).isEqual(to: _ei(4)))
    }

    @Test
    func isEqual_to() {}

    @Test
    func isLess_than() {}

    @Test
    func isMultiple_of() {}

    @Test
    func leastCommonMultiple_with() {
        #expect(_ei(32).leastCommonMultiple(with: _ei(-36)).isEqual(to: _ei(288)))
    }

    @Test
    func modulo() {
        #expect(_ei(13).modulo(_ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).modulo(_ei(4)).isEqual(to: _ei(3)))
        #expect(_ei(13).modulo(_ei(-4)).isEqual(to: _ei(-3)))
        #expect(_ei(-13).modulo(_ei(-4)).isEqual(to: _ei(-1)))
    }

    @Test
    func multiplied_by() {}

    @Test
    func negated() {}

    @Test
    func quotient_dividingBy() {}

    @Test
    func remainder_dividingBy() {
        #expect(_ei(13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(-1)))
        #expect(_ei(13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(-1)))
    }

    @Test
    func subtracting() {}
}

// MARK: -

extension ExactIntegerTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }
}
