import XCTest
@testable import XestiMath

internal class RealTests: XCTestCase {
}

// MARK: -

extension RealTests {
    func test_checkInteger() {
    }

    func test_checkRational() {
    }

    func test_coerce() {
    }

    func test_description() {
    }

    func test_doubleValue() {
    }

    func test_encode() {
    }

    func test_exactIntegerValue() {
    }

    func test_init_decoder() {
    }

    func test_init_integerLiteral() {
    }

    func test_init_stringLiteral() {
    }

    func test_isExactInteger() {
    }
}

// MARK: -

extension RealTests {
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
