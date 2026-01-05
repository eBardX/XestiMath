// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct ExactIntegerTests {
}

// MARK: - Test internal type methods

extension ExactIntegerTests {
    @Test
    func test_parse_radix() {}
}

// MARK: - Test internal initializers

extension ExactIntegerTests {
    @Test
    func test_init_binaryFloatingPoint() {}

    @Test
    func test_init_binaryInteger() {}
}

// MARK: - Test internal instance properties

extension ExactIntegerTests {
    @Test
    func test_debugDescription() {}

    @Test
    func test_description() {}

    @Test
    func test_floatingPointValue() {}

    @Test
    func test_int16Value() {}

    @Test
    func test_int32Value() {}

    @Test
    func test_int64Value() {}

    @Test
    func test_int8Value() {}

    @Test
    func test_intValue() {}

    @Test
    func test_isEven() {}

    @Test
    func test_isNegative() {}

    @Test
    func test_isOdd() {}

    @Test
    func test_isPositive() {}

    @Test
    func test_isZero() {}

    @Test
    func test_uint16Value() {}

    @Test
    func test_uint32Value() {}

    @Test
    func test_uint64Value() {}

    @Test
    func test_uint8Value() {}

    @Test
    func test_uintValue() {}
}

// MARK: - Test internal instance methods

extension ExactIntegerTests {
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
    func test_greatestCommonDivisor_with() {
        #expect(_ei(32).greatestCommonDivisor(with: _ei(-36)).isEqual(to: _ei(4)))
    }

    @Test
    func test_isEqual_to() {}

    @Test
    func test_isLess_than() {}

    @Test
    func test_isMultiple_of() {}

    @Test
    func test_leastCommonMultiple_with() {
        #expect(_ei(32).leastCommonMultiple(with: _ei(-36)).isEqual(to: _ei(288)))
    }

    @Test
    func test_modulo() {
        #expect(_ei(13).modulo(_ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).modulo(_ei(4)).isEqual(to: _ei(3)))
        #expect(_ei(13).modulo(_ei(-4)).isEqual(to: _ei(-3)))
        #expect(_ei(-13).modulo(_ei(-4)).isEqual(to: _ei(-1)))
    }

    @Test
    func test_multiplied_by() {}

    @Test
    func test_negated() {}

    @Test
    func test_quotient_dividingBy() {}

    @Test
    func test_remainder_dividingBy() {
        #expect(_ei(13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(-1)))
        #expect(_ei(13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(-1)))
    }

    @Test
    func test_subtracting() {}
}

// MARK: -

extension ExactIntegerTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }
}
