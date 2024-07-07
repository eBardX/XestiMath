import XCTest
@testable import XestiMath

internal class ExactIntegerTests: XCTestCase {
}

// MARK: -

extension ExactIntegerTests {
    func test_coerce() {
    }

    func test_description() {
    }

    func test_doubleValue() {
    }

    func test_encode() {
    }

    func test_hash() {
    }

    func test_init_decoder() {
    }

    func test_init_integerLiteral() {
    }

    func test_init_stringLiteral() {
    }

    func test_playgroundDescription() {
    }
}

// MARK: -

extension ExactIntegerTests {
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
