// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct ExactIntegerTests {
}

// MARK: - Test internal type methods

extension ExactIntegerTests {
    @Test
    func test_parse_radix() {
        #expect(ExactInteger.parse(input: "42", radix: .decimal)?.isEqual(to: _ei(42)) == true)
        #expect(ExactInteger.parse(input: "-7", radix: .decimal)?.isEqual(to: _ei(-7)) == true)
        #expect(ExactInteger.parse(input: "0", radix: .decimal)?.isEqual(to: _ei(0)) == true)
        #expect(ExactInteger.parse(input: "101010", radix: .binary)?.isEqual(to: _ei(42)) == true)
        #expect(ExactInteger.parse(input: "-101", radix: .binary)?.isEqual(to: _ei(-5)) == true)
        #expect(ExactInteger.parse(input: "2a", radix: .hexadecimal)?.isEqual(to: _ei(42)) == true)
        #expect(ExactInteger.parse(input: "ff", radix: .hexadecimal)?.isEqual(to: _ei(255)) == true)
        #expect(ExactInteger.parse(input: "52", radix: .octal)?.isEqual(to: _ei(42)) == true)
        #expect(ExactInteger.parse(input: "xyz", radix: .decimal) == nil)
        #expect(ExactInteger.parse(input: "29", radix: .octal) == nil)
        #expect(ExactInteger.parse(input: "2g", radix: .hexadecimal) == nil)
    }
}

// MARK: - Test internal initializers

extension ExactIntegerTests {
    @Test
    func test_init_binaryFloatingPoint() {
        #expect(ExactInteger(3.0).isEqual(to: _ei(3)))
        #expect(ExactInteger(-5.0).isEqual(to: _ei(-5)))
        #expect(ExactInteger(0.0).isEqual(to: _ei(0)))
        #expect(ExactInteger(100.0).isEqual(to: _ei(100)))
    }

    @Test
    func test_init_binaryInteger() {
        #expect(ExactInteger(42).isEqual(to: _ei(42)))
        #expect(ExactInteger(-7).isEqual(to: _ei(-7)))
        #expect(ExactInteger(0).isEqual(to: _ei(0)))
        #expect(ExactInteger(Int.max).intValue == Int.max)
        #expect(ExactInteger(Int.min).intValue == Int.min)
    }
}

// MARK: - Test internal instance properties

extension ExactIntegerTests {
    @Test
    func test_debugDescription() {
        #expect(String(reflecting: _ei(42)) == "small<42>")
        #expect(String(reflecting: _ei(-7)) == "small<-7>")
        #expect(String(reflecting: _ei(0)) == "small<0>")
        let large = _ei(Int.max).adding(_ei(1))
        #expect(String(reflecting: large).hasPrefix("large<"))
    }

    @Test
    func test_description() {
        #expect(String(describing: _ei(42)) == "42")
        #expect(String(describing: _ei(-7)) == "-7")
        #expect(String(describing: _ei(0)) == "0")
        #expect(String(describing: ExactInteger.one) == "1")
        #expect(String(describing: ExactInteger.zero) == "0")
    }

    @Test
    func test_floatingPointValue() {
        #expect(_ei(42).floatingPointValue.doubleValue == 42.0)
        #expect(_ei(-7).floatingPointValue.doubleValue == -7.0)
        #expect(_ei(0).floatingPointValue.doubleValue == 0.0)
    }

    @Test
    func test_int16Value() {
        #expect(_ei(42).int16Value == 42)
        #expect(_ei(-7).int16Value == -7)
        #expect(_ei(0).int16Value == 0)
    }

    @Test
    func test_int32Value() {
        #expect(_ei(42).int32Value == 42)
        #expect(_ei(-7).int32Value == -7)
        #expect(_ei(0).int32Value == 0)
    }

    @Test
    func test_int64Value() {
        #expect(_ei(42).int64Value == 42)
        #expect(_ei(-7).int64Value == -7)
        #expect(_ei(0).int64Value == 0)
    }

    @Test
    func test_int8Value() {
        #expect(_ei(42).int8Value == 42)
        #expect(_ei(-7).int8Value == -7)
        #expect(_ei(0).int8Value == 0)
    }

    @Test
    func test_intValue() {
        #expect(_ei(42).intValue == 42)
        #expect(_ei(-7).intValue == -7)
        #expect(_ei(0).intValue == 0)
        #expect(_ei(Int.max).intValue == Int.max)
        #expect(_ei(Int.min).intValue == Int.min)
    }

    @Test
    func test_isEven() {
        #expect(_ei(0).isEven)
        #expect(_ei(2).isEven)
        #expect(_ei(-4).isEven)
        #expect(!_ei(1).isEven)
        #expect(!_ei(-3).isEven)
    }

    @Test
    func test_isNegative() {
        #expect(_ei(-1).isNegative)
        #expect(_ei(-100).isNegative)
        #expect(!_ei(0).isNegative)
        #expect(!_ei(1).isNegative)
        #expect(!_ei(42).isNegative)
    }

    @Test
    func test_isOdd() {
        #expect(_ei(1).isOdd)
        #expect(_ei(-3).isOdd)
        #expect(!_ei(0).isOdd)
        #expect(!_ei(2).isOdd)
        #expect(!_ei(-4).isOdd)
    }

    @Test
    func test_isPositive() {
        #expect(_ei(1).isPositive)
        #expect(_ei(42).isPositive)
        #expect(!_ei(0).isPositive)
        #expect(!_ei(-1).isPositive)
        #expect(!_ei(-42).isPositive)
    }

    @Test
    func test_isZero() {
        #expect(_ei(0).isZero)
        #expect(ExactInteger.zero.isZero)
        #expect(!_ei(1).isZero)
        #expect(!_ei(-1).isZero)
        #expect(!_ei(42).isZero)
    }

    @Test
    func test_uint16Value() {
        #expect(_ei(42).uint16Value == 42)
        #expect(_ei(0).uint16Value == 0)
        #expect(_ei(255).uint16Value == 255)
    }

    @Test
    func test_uint32Value() {
        #expect(_ei(42).uint32Value == 42)
        #expect(_ei(0).uint32Value == 0)
        #expect(_ei(100_000).uint32Value == 100_000)
    }

    @Test
    func test_uint64Value() {
        #expect(_ei(42).uint64Value == 42)
        #expect(_ei(0).uint64Value == 0)
        #expect(_ei(Int.max).uint64Value == UInt64(Int.max))
    }

    @Test
    func test_uint8Value() {
        #expect(_ei(42).uint8Value == 42)
        #expect(_ei(0).uint8Value == 0)
        #expect(_ei(255).uint8Value == 255)
    }

    @Test
    func test_uintValue() {
        #expect(_ei(42).uintValue == 42)
        #expect(_ei(0).uintValue == 0)
        #expect(_ei(Int.max).uintValue == UInt(Int.max))
    }
}

// MARK: - Test internal instance methods

extension ExactIntegerTests {
    @Test
    func test_adding() {
        #expect(_ei(3).adding(_ei(4)).isEqual(to: _ei(7)))
        #expect(_ei(-3).adding(_ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(0).adding(_ei(5)).isEqual(to: _ei(5)))
        #expect(_ei(-3).adding(_ei(-4)).isEqual(to: _ei(-7)))
        let large = _ei(Int.max).adding(_ei(1))
        #expect(large.adding(_ei(-1)).isEqual(to: _ei(Int.max)))
    }

    @Test
    func test_bitwiseAnd_with() {
        #expect(_ei(0b1100).bitwiseAnd(with: _ei(0b1010)).isEqual(to: _ei(0b1000)))
        #expect(_ei(0xFF).bitwiseAnd(with: _ei(0x0F)).isEqual(to: _ei(0x0F)))
        #expect(_ei(0).bitwiseAnd(with: _ei(42)).isEqual(to: _ei(0)))
        #expect(_ei(-1).bitwiseAnd(with: _ei(42)).isEqual(to: _ei(42)))
    }

    @Test
    func test_bitwiseNot() {
        #expect(_ei(0).bitwiseNot().isEqual(to: _ei(-1)))
        #expect(_ei(-1).bitwiseNot().isEqual(to: _ei(0)))
        #expect(_ei(42).bitwiseNot().isEqual(to: _ei(-43)))
    }

    @Test
    func test_bitwiseOr_with() {
        #expect(_ei(0b1100).bitwiseOr(with: _ei(0b1010)).isEqual(to: _ei(0b1110)))
        #expect(_ei(0).bitwiseOr(with: _ei(42)).isEqual(to: _ei(42)))
        #expect(_ei(0xFF).bitwiseOr(with: _ei(0x0F)).isEqual(to: _ei(0xFF)))
    }

    @Test
    func test_bitwiseShiftLeft_bits() {
        #expect(_ei(1).bitwiseShiftLeft(bits: 3).isEqual(to: _ei(8)))
        #expect(_ei(5).bitwiseShiftLeft(bits: 0).isEqual(to: _ei(5)))
        #expect(_ei(3).bitwiseShiftLeft(bits: 4).isEqual(to: _ei(48)))
    }

    @Test
    func test_bitwiseShiftRight_bits() {
        #expect(_ei(8).bitwiseShiftRight(bits: 3).isEqual(to: _ei(1)))
        #expect(_ei(5).bitwiseShiftRight(bits: 0).isEqual(to: _ei(5)))
        #expect(_ei(48).bitwiseShiftRight(bits: 4).isEqual(to: _ei(3)))
    }

    @Test
    func test_bitwiseXor_with() {
        #expect(_ei(0b1100).bitwiseXor(with: _ei(0b1010)).isEqual(to: _ei(0b0110)))
        #expect(_ei(42).bitwiseXor(with: _ei(0)).isEqual(to: _ei(42)))
        #expect(_ei(42).bitwiseXor(with: _ei(42)).isEqual(to: _ei(0)))
    }

    @Test
    func test_compare_to() {
        #expect(_ei(1).isLess(than: _ei(2)))
        #expect(!_ei(2).isLess(than: _ei(1)))
        #expect(!_ei(1).isLess(than: _ei(1)))
        #expect(_ei(-1).isLess(than: _ei(0)))
        #expect(_ei(0).isLess(than: _ei(1)))
        let large = _ei(Int.max).adding(_ei(1))
        #expect(_ei(Int.max).isLess(than: large))
    }

    @Test
    func test_greatestCommonDivisor_with() {
        #expect(_ei(32).greatestCommonDivisor(with: _ei(-36)).isEqual(to: _ei(4)))
    }

    @Test
    func test_isEqual_to() {
        #expect(_ei(42).isEqual(to: _ei(42)))
        #expect(!_ei(42).isEqual(to: _ei(43)))
        #expect(_ei(0).isEqual(to: _ei(0)))
        #expect(_ei(-7).isEqual(to: _ei(-7)))
        #expect(!_ei(-7).isEqual(to: _ei(7)))
    }

    @Test
    func test_isMultiple_of() {
        #expect(_ei(6).isMultiple(of: _ei(3)))
        #expect(_ei(0).isMultiple(of: _ei(5)))
        #expect(!_ei(7).isMultiple(of: _ei(3)))
        #expect(_ei(10).isMultiple(of: _ei(1)))
        #expect(_ei(-6).isMultiple(of: _ei(3)))
    }

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
    func test_multiplied_by() {
        #expect(_ei(3).multiplied(by: _ei(4)).isEqual(to: _ei(12)))
        #expect(_ei(-3).multiplied(by: _ei(4)).isEqual(to: _ei(-12)))
        #expect(_ei(0).multiplied(by: _ei(42)).isEqual(to: _ei(0)))
        #expect(_ei(1).multiplied(by: _ei(7)).isEqual(to: _ei(7)))
        let large = _ei(Int.max).multiplied(by: _ei(2))
        #expect(large.isEqual(to: _ei(Int.max).adding(_ei(Int.max))))
    }

    @Test
    func test_negated() {
        #expect(_ei(42).negated().isEqual(to: _ei(-42)))
        #expect(_ei(-7).negated().isEqual(to: _ei(7)))
        #expect(_ei(0).negated().isEqual(to: _ei(0)))
        #expect(_ei(1).negated().negated().isEqual(to: _ei(1)))
    }

    @Test
    func test_quotient_dividingBy() {
        #expect(_ei(12).quotient(dividingBy: _ei(4)).isEqual(to: _ei(3)))
        #expect(_ei(13).quotient(dividingBy: _ei(4)).isEqual(to: _ei(3)))
        #expect(_ei(-12).quotient(dividingBy: _ei(4)).isEqual(to: _ei(-3)))
        #expect(_ei(0).quotient(dividingBy: _ei(5)).isEqual(to: _ei(0)))
    }

    @Test
    func test_remainder_dividingBy() {
        #expect(_ei(13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(4)).isEqual(to: _ei(-1)))
        #expect(_ei(13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(1)))
        #expect(_ei(-13).remainder(dividingBy: _ei(-4)).isEqual(to: _ei(-1)))
    }

    @Test
    func test_subtracting() {
        #expect(_ei(7).subtracting(_ei(3)).isEqual(to: _ei(4)))
        #expect(_ei(3).subtracting(_ei(7)).isEqual(to: _ei(-4)))
        #expect(_ei(0).subtracting(_ei(0)).isEqual(to: _ei(0)))
        #expect(_ei(-3).subtracting(_ei(-7)).isEqual(to: _ei(4)))
        let large = _ei(Int.max).adding(_ei(1))
        #expect(large.subtracting(_ei(1)).isEqual(to: _ei(Int.max)))
    }
}

// MARK: -

extension ExactIntegerTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }
}
