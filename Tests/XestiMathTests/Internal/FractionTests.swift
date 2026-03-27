// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct FractionTests {
}

// MARK: - Test internal type methods

extension FractionTests {
    @Test
    func test_parse_radix() {
        #expect(Fraction.parse(input: "3/4", radix: .decimal)?.isEqual(to: _fr(3, 4)) == true)
        #expect(Fraction.parse(input: "-7/8", radix: .decimal)?.isEqual(to: _fr(-7, 8)) == true)
        #expect(Fraction.parse(input: "0/1", radix: .decimal)?.isEqual(to: _fr(0, 1)) == true)
        #expect(Fraction.parse(input: "10/3", radix: .decimal)?.isEqual(to: _fr(10, 3)) == true)
        #expect(Fraction.parse(input: "11/100", radix: .binary)?.isEqual(to: _fr(3, 4)) == true)
        #expect(Fraction.parse(input: "a/b", radix: .hexadecimal)?.isEqual(to: _fr(10, 11)) == true)
        #expect(Fraction.parse(input: "7/10", radix: .octal)?.isEqual(to: _fr(7, 8)) == true)
        #expect(Fraction.parse(input: "invalid", radix: .decimal) == nil)
        #expect(Fraction.parse(input: "", radix: .decimal) == nil)
    }
}

// MARK: - Test internal initializers

extension FractionTests {
    @Test
    func test_init_numerator_denominator_reduce() {
        let reduced = Fraction(numerator: _ei(4), denominator: _ei(8))

        #expect(reduced.numerator.isEqual(to: _ei(1)))
        #expect(reduced.denominator.isEqual(to: _ei(2)))

        let unreduced = Fraction(numerator: _ei(4), denominator: _ei(8), reduce: false)

        #expect(unreduced.numerator.isEqual(to: _ei(4)))
        #expect(unreduced.denominator.isEqual(to: _ei(8)))

        let negDen = Fraction(numerator: _ei(3), denominator: _ei(-4))

        #expect(negDen.numerator.isEqual(to: _ei(-3)))
        #expect(negDen.denominator.isEqual(to: _ei(4)))

        let zeroNum = Fraction(numerator: _ei(0), denominator: _ei(5))

        #expect(zeroNum.numerator.isEqual(to: _ei(0)))
        #expect(zeroNum.denominator.isEqual(to: _ei(1)))
    }
}

// MARK: - Test internal instance properties

extension FractionTests {
    @Test
    func test_debugDescription() {
        #expect(_fr(3, 4).debugDescription == "fraction<small<3>, small<4>>")
        #expect(_fr(-1, 2).debugDescription == "fraction<small<-1>, small<2>>")
        #expect(_fr(0, 1).debugDescription == "fraction<small<0>, small<1>>")
    }

    @Test
    func test_denominator() {
        #expect(_fr(3, 4).denominator.isEqual(to: _ei(4)))
        #expect(_fr(1, 1).denominator.isEqual(to: _ei(1)))
        #expect(_fr(7, 3).denominator.isEqual(to: _ei(3)))
    }

    @Test
    func test_description() {
        #expect(_fr(3, 4).description == "3/4")
        #expect(_fr(-1, 2).description == "-1/2")
        #expect(_fr(0, 1).description == "0/1")
        #expect(_fr(7, 3).description == "7/3")
    }

    @Test
    func test_exactIntegerValue() {
        #expect(_fr(10, 5).exactIntegerValue.isEqual(to: _ei(2)))
        #expect(_fr(7, 3).exactIntegerValue.isEqual(to: _ei(2)))
        #expect(_fr(0, 5).exactIntegerValue.isEqual(to: _ei(0)))
        #expect(_fr(-7, 2).exactIntegerValue.isEqual(to: _ei(-3)))
    }

    @Test
    func test_floatingPointValue() {
        #expect(_fr(1, 2).floatingPointValue.doubleValue == 0.5)
        #expect(_fr(1, 4).floatingPointValue.doubleValue == 0.25)
        #expect(_fr(-3, 4).floatingPointValue.doubleValue == -0.75)
        #expect(_fr(1, 1).floatingPointValue.doubleValue == 1.0)
    }

    @Test
    func test_isInteger() {
        #expect(_fr(4, 1).isInteger)
        #expect(_fr(0, 1).isInteger)
        #expect(_fr(6, 3).isInteger)
        #expect(!_fr(1, 2).isInteger)
        #expect(!_fr(7, 3).isInteger)
    }

    @Test
    func test_isNegative() {
        #expect(_fr(-1, 2).isNegative)
        #expect(_fr(-5, 3).isNegative)
        #expect(!_fr(1, 2).isNegative)
        #expect(!_fr(0, 1).isNegative)
    }

    @Test
    func test_isPositive() {
        #expect(_fr(1, 2).isPositive)
        #expect(_fr(5, 3).isPositive)
        #expect(!_fr(-1, 2).isPositive)
        #expect(!_fr(0, 1).isPositive)
    }

    @Test
    func test_isZero() {
        #expect(_fr(0, 1).isZero)
        #expect(_fr(0, 5).isZero)
        #expect(!_fr(1, 2).isZero)
        #expect(!_fr(-1, 2).isZero)
    }

    @Test
    func test_numerator() {
        #expect(_fr(3, 4).numerator.isEqual(to: _ei(3)))
        #expect(_fr(-1, 2).numerator.isEqual(to: _ei(-1)))
        #expect(_fr(0, 5).numerator.isEqual(to: _ei(0)))
    }
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
        #expect(_fr(1, 2).isEqual(to: _fr(1, 2)))
        #expect(_fr(2, 4).isEqual(to: _fr(1, 2)))
        #expect(_fr(0, 1).isEqual(to: _fr(0, 3)))
        #expect(!_fr(1, 2).isEqual(to: _fr(1, 3)))
        #expect(!_fr(1, 2).isEqual(to: _fr(2, 3)))
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
        #expect(_fr(3, 4).negated().isEqual(to: _fr(-3, 4)))
        #expect(_fr(-3, 4).negated().isEqual(to: _fr(3, 4)))
        #expect(_fr(0, 1).negated().isEqual(to: _fr(0, 1)))
        #expect(_fr(1, 2).negated().negated().isEqual(to: _fr(1, 2)))
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
