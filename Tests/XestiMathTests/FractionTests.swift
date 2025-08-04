// © 2025 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct FractionTests {
}

// MARK: - Test internal type methods

extension FractionTests {
    @Test
    func parse_radix() {}
}

// MARK: - Test internal initializers

extension FractionTests {
    @Test
    func init_numerator_denominator_reduce() {}
}

// MARK: - Test internal instance properties

extension FractionTests {
    @Test
    func debugDescription() {}

    @Test
    func denominator() {}

    @Test
    func description() {}

    @Test
    func exactIntegerValue() {}

    @Test
    func floatingPointValue() {}

    @Test
    func isInteger() {}

    @Test
    func isNegative() {}

    @Test
    func isPositive() {}

    @Test
    func isZero() {}

    @Test
    func numerator() {}
}

// MARK: - Test internal instance methods

extension FractionTests {
    @Test
    func adding() {
        #expect(_fr(1, 2).adding(_fr(1, 6)).isEqual(to: _fr(2, 3)))
    }

    @Test
    func ceiling() {
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
    func divided_by() {
        #expect(_fr(2, 3).divided(by: _fr(1, 6)).isEqual(to: _fr(4, 1)))
    }

    @Test
    func floor() {
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
    func isEqual_to() {
    }

    @Test
    func isLess_than() {
        #expect(_fr(5, 8).isLess(than: _fr(3, 4)))
    }

    @Test
    func multiplied_by () {
        #expect(_fr(2, 3).multiplied(by: _fr(1, 6)).isEqual(to: _fr(1, 9)))
    }

    @Test
    func negated () {
    }

    @Test
    func round() {
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
    func subtracting() {
        #expect(_fr(2, 3).subtracting(_fr(1, 6)).isEqual(to: _fr(1, 2)))
    }

    @Test
    func truncate() {
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
