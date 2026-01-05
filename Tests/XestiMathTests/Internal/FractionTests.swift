// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct FractionTests {
}

// MARK: - Test internal type methods

extension FractionTests {
    @Test
    func test_parse_radix() {}
}

// MARK: - Test internal initializers

extension FractionTests {
    @Test
    func test_init_numerator_denominator_reduce() {}
}

// MARK: - Test internal instance properties

extension FractionTests {
    @Test
    func test_debugDescription() {}

    @Test
    func test_denominator() {}

    @Test
    func test_description() {}

    @Test
    func test_exactIntegerValue() {}

    @Test
    func test_floatingPointValue() {}

    @Test
    func test_isInteger() {}

    @Test
    func test_isNegative() {}

    @Test
    func test_isPositive() {}

    @Test
    func test_isZero() {}

    @Test
    func test_numerator() {}
}

// MARK: - Test internal instance methods

extension FractionTests {
    @Test
    func test_adding() {
        #expect(_fr(1, 2).adding(_fr(1, 6)).isEqual(to: _fr(2, 3)))
    }

    @Test
    func test_ceiling() {
        #expect(_fr(-50, 10).ceiling().isEqual(to: _ei(-5)))
        #expect(_fr(-43, 10).ceiling().isEqual(to: _ei(-4)))
        #expect(_fr(-35, 10).ceiling().isEqual(to: _ei(-3)))
        #expect(_fr(-5, 10).ceiling().isEqual(to: _ei(0)))
        #expect(_fr(0, 10).ceiling().isEqual(to: _ei(0)))
        #expect(_fr(5, 10).ceiling().isEqual(to: _ei(1)))
        #expect(_fr(35, 10).ceiling().isEqual(to: _ei(4)))
        #expect(_fr(43, 10).ceiling().isEqual(to: _ei(5)))
        #expect(_fr(50, 10).ceiling().isEqual(to: _ei(5)))
    }

    @Test
    func test_divided_by() {
        #expect(_fr(2, 3).divided(by: _fr(1, 6)).isEqual(to: _fr(4, 1)))
    }

    @Test
    func test_floor() {
        #expect(_fr(-50, 10).floor().isEqual(to: _ei(-5)))
        #expect(_fr(-43, 10).floor().isEqual(to: _ei(-5)))
        #expect(_fr(-35, 10).floor().isEqual(to: _ei(-4)))
        #expect(_fr(-5, 10).floor().isEqual(to: _ei(-1)))
        #expect(_fr(0, 10).floor().isEqual(to: _ei(0)))
        #expect(_fr(5, 10).floor().isEqual(to: _ei(0)))
        #expect(_fr(35, 10).floor().isEqual(to: _ei(3)))
        #expect(_fr(43, 10).floor().isEqual(to: _ei(4)))
        #expect(_fr(50, 10).floor().isEqual(to: _ei(5)))
    }

    @Test
    func test_isEqual_to() {
    }

    @Test
    func test_isLess_than() {
        #expect(_fr(5, 8).isLess(than: _fr(3, 4)))
    }

    @Test
    func test_multiplied_by () {
        #expect(_fr(2, 3).multiplied(by: _fr(1, 6)).isEqual(to: _fr(1, 9)))
    }

    @Test
    func test_negated () {
    }

    @Test
    func test_round() {
        #expect(_fr(-50, 10).round().isEqual(to: _ei(-5)))
        #expect(_fr(-43, 10).round().isEqual(to: _ei(-4)))
        #expect(_fr(-35, 10).round().isEqual(to: _ei(-4)))
        #expect(_fr(-5, 10).round().isEqual(to: _ei(0)))
        #expect(_fr(0, 10).round().isEqual(to: _ei(0)))
        #expect(_fr(5, 10).round().isEqual(to: _ei(0)))
        #expect(_fr(35, 10).round().isEqual(to: _ei(4)))
        #expect(_fr(43, 10).round().isEqual(to: _ei(4)))
        #expect(_fr(50, 10).round().isEqual(to: _ei(5)))
    }

    @Test
    func test_subtracting() {
        #expect(_fr(2, 3).subtracting(_fr(1, 6)).isEqual(to: _fr(1, 2)))
    }

    @Test
    func test_truncate() {
        #expect(_fr(-50, 10).truncate().isEqual(to: _ei(-5)))
        #expect(_fr(-43, 10).truncate().isEqual(to: _ei(-4)))
        #expect(_fr(-35, 10).truncate().isEqual(to: _ei(-3)))
        #expect(_fr(-5, 10).truncate().isEqual(to: _ei(0)))
        #expect(_fr(0, 10).truncate().isEqual(to: _ei(0)))
        #expect(_fr(5, 10).truncate().isEqual(to: _ei(0)))
        #expect(_fr(35, 10).truncate().isEqual(to: _ei(3)))
        #expect(_fr(43, 10).truncate().isEqual(to: _ei(4)))
        #expect(_fr(50, 10).truncate().isEqual(to: _ei(5)))
    }
}

// MARK: -

extension FractionTests {
    private func _ei<T: BinaryInteger>(_ val: T) -> ExactInteger {
        ExactInteger(val)
    }

    private func _fr<T: BinaryInteger>(_ num: T,
                                       _ den: T) -> Fraction {
        Fraction(numerator: _ei(num),
                 denominator: _ei(den))
    }
}
