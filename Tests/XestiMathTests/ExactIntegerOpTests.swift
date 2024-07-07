import XCTest
@testable import XestiMath

internal class ExactIntegerOpTests: XCTestCase {
}

// MARK: -

extension ExactIntegerOpTests {
    func test_abs() {
    }

    func test_add_op() {
    }

    func test_and_op() {
    }

    func test_div_op() {
    }

    func test_diveq_op() {
    }

    func test_eq_op() {
    }

    func test_gcd() {
    }

    func test_isEven() {
    }

    func test_isOdd() {
    }

    func test_lcm() {
    }

    func test_lshift_op() {
    }

    func test_lt_op() {
    }

    func test_max() {
    }

    func test_min() {
    }

    func test_modulo() {
    }

    func test_mul_op() {
    }

    func test_neg_op() {
    }

    func test_not_op() {
    }

    func test_or_op() {
    }

    func test_quotient() {
    }

    func test_quotientAndRemainder1() {
        let n1: ExactInteger = 2_001
        let n2: ExactInteger = 751

        let (quo, rem) = quotientAndRemainder(n1, n2)

        XCTAssertEqual(quo, n1 / n2)
        XCTAssertEqual(rem, n1 % n2)
    }

    func test_quotientAndRemainder2() {
        let n1: ExactInteger = -2_001
        let n2: ExactInteger = 751

        let (quo, rem) = quotientAndRemainder(n1, n2)

        XCTAssertEqual(quo, n1 / n2)
        XCTAssertEqual(rem, n1 % n2)
    }

    func test_quotientAndRemainder3() {
        let n1: ExactInteger = 2_001
        let n2: ExactInteger = -751

        let (quo, rem) = quotientAndRemainder(n1, n2)

        XCTAssertEqual(quo, n1 / n2)
        XCTAssertEqual(rem, n1 % n2)
    }

    func test_quotientAndRemainder4() {
        let n1: ExactInteger = -2_001
        let n2: ExactInteger = -751

        let (quo, rem) = quotientAndRemainder(n1, n2)

        XCTAssertEqual(quo, n1 / n2)
        XCTAssertEqual(rem, n1 % n2)
    }

    func test_rem_op() {
    }

    func test_remainder() {
    }

    func test_rshift_op() {
    }

    func test_sqrt() {
    }

    func test_sub_op() {
    }

    func test_xor_op() {
    }
}

// MARK: -

// extension ExactIntegerOpTests {
//    private func _testInit(_ inNum: ExactInteger,
//                           _ inDen: ExactInteger,
//                           _ normalize: Bool,
//                           _ outNum: ExactInteger,
//                           _ outDen: ExactInteger,
//                           file: StaticString = #filePath,
//                           line: UInt = #line) {
//        let frac = Fraction(inNum, inDen, normalize)
//
//        XCTAssertEqual(frac.numerator, outNum, file: file, line: line)
//        XCTAssertEqual(frac.denominator, outDen, file: file, line: line)
//    }
// }
