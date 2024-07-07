import XCTest
@testable import XestiMath

internal class IntExtensionsTests: XCTestCase {
}

// MARK: -

extension IntExtensionsTests {
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
}

// MARK: -

extension IntExtensionsTests {
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
