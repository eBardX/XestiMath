// © 2025—2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct DoubleExtensionsTests {
}

// MARK: -

extension DoubleExtensionsTests {
    @Test
    func test_convertToFraction() {
        #expect(Double.convertToFraction(-1.75) == (-7, 4))
        #expect(Double.convertToFraction(.pi) == (355, 113))
        #expect(Double.convertToFraction(.zero) == (0, 1))
        #expect(Double.convertToFraction(1.03125) == (33, 32))
        #expect(Double.convertToFraction(5.0 / 17.0) == (5, 17))
    }
}

// MARK: -

// extension IntExtensionsTests {
// }
