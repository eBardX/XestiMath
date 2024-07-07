import XCTest
@testable import XestiMath

internal class FractionTests: XCTestCase {
}

// MARK: -

extension FractionTests {
    func test_ceiling() {
        XCTAssertEqual(Fraction(-50, 10).ceiling(), ExactInteger(integerLiteral: -5))
        XCTAssertEqual(Fraction(-43, 10).ceiling(), ExactInteger(integerLiteral: -4))
        XCTAssertEqual(Fraction(-35, 10).ceiling(), ExactInteger(integerLiteral: -3))
        XCTAssertEqual(Fraction(-5, 10).ceiling(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(0, 10).ceiling(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(5, 10).ceiling(), ExactInteger(integerLiteral: 1))
        XCTAssertEqual(Fraction(35, 10).ceiling(), ExactInteger(integerLiteral: 4))
        XCTAssertEqual(Fraction(43, 10).ceiling(), ExactInteger(integerLiteral: 5))
        XCTAssertEqual(Fraction(50, 10).ceiling(), ExactInteger(integerLiteral: 5))
    }

    func test_denominator() {
    }

    func test_description() {
    }

    func test_doubleValue() {
    }

    func test_encode() {
    }

    func test_exactIntegerValue() {
    }

    func test_floor() {
        XCTAssertEqual(Fraction(-50, 10).floor(), ExactInteger(integerLiteral: -5))
        XCTAssertEqual(Fraction(-43, 10).floor(), ExactInteger(integerLiteral: -5))
        XCTAssertEqual(Fraction(-35, 10).floor(), ExactInteger(integerLiteral: -4))
        XCTAssertEqual(Fraction(-5, 10).floor(), ExactInteger(integerLiteral: -1))
        XCTAssertEqual(Fraction(0, 10).floor(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(5, 10).floor(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(35, 10).floor(), ExactInteger(integerLiteral: 3))
        XCTAssertEqual(Fraction(43, 10).floor(), ExactInteger(integerLiteral: 4))
        XCTAssertEqual(Fraction(50, 10).floor(), ExactInteger(integerLiteral: 5))
    }

    func test_init() {
        _testInit(0, 1, false, 0, 1)
        _testInit(1, 1, false, 1, 1)
        _testInit(2, 1, false, 2, 1)
        _testInit(0, 2, false, 0, 2)
        _testInit(1, 2, false, 1, 2)
        _testInit(2, 2, false, 2, 2)

        _testInit(0, 1, true, 0, 1)
        _testInit(1, 1, true, 1, 1)
        _testInit(2, 1, true, 2, 1)
        _testInit(0, 2, true, 0, 1)
        _testInit(1, 2, true, 1, 2)
        _testInit(2, 2, true, 1, 1)
    }

    func test_init_decoder() {
    }

    func test_init_hash() {
    }

    func test_init_integerLiteral() {
    }

    func test_init_stringLiteral() {
    }

    func test_isExactInteger() {
    }

    func test_numerator() {
    }

    func test_round() {
        XCTAssertEqual(Fraction(-50, 10).round(), ExactInteger(integerLiteral: -5))
        XCTAssertEqual(Fraction(-43, 10).round(), ExactInteger(integerLiteral: -4))
        XCTAssertEqual(Fraction(-35, 10).round(), ExactInteger(integerLiteral: -4))
        XCTAssertEqual(Fraction(-5, 10).round(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(0, 10).round(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(5, 10).round(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(35, 10).round(), ExactInteger(integerLiteral: 4))
        XCTAssertEqual(Fraction(43, 10).round(), ExactInteger(integerLiteral: 4))
        XCTAssertEqual(Fraction(50, 10).round(), ExactInteger(integerLiteral: 5))
    }

    func test_truncate() {
        XCTAssertEqual(Fraction(-50, 10).truncate(), ExactInteger(integerLiteral: -5))
        XCTAssertEqual(Fraction(-43, 10).truncate(), ExactInteger(integerLiteral: -4))
        XCTAssertEqual(Fraction(-35, 10).truncate(), ExactInteger(integerLiteral: -3))
        XCTAssertEqual(Fraction(-5, 10).truncate(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(0, 10).truncate(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(5, 10).truncate(), ExactInteger(integerLiteral: 0))
        XCTAssertEqual(Fraction(35, 10).truncate(), ExactInteger(integerLiteral: 3))
        XCTAssertEqual(Fraction(43, 10).truncate(), ExactInteger(integerLiteral: 4))
        XCTAssertEqual(Fraction(50, 10).truncate(), ExactInteger(integerLiteral: 5))
    }
}

// MARK: -

extension FractionTests {
    private func _testInit(_ inNum: ExactInteger,
                           _ inDen: ExactInteger,
                           _ normalize: Bool,
                           _ outNum: ExactInteger,
                           _ outDen: ExactInteger,
                           file: StaticString = #filePath,
                           line: UInt = #line) {
        let frac = Fraction(inNum, inDen, normalize)

        XCTAssertEqual(frac.numerator, outNum, file: file, line: line)
        XCTAssertEqual(frac.denominator, outDen, file: file, line: line)
    }
}
