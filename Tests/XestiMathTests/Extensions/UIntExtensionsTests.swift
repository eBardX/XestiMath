// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct UIntExtensionsTests {
}

// MARK: -

extension UIntExtensionsTests {
    @Test
    func test_gcd() {
        #expect(UInt.gcd(12, 8) == 4)
        #expect(UInt.gcd(7, 5) == 1)
        #expect(UInt.gcd(0, 5) == 5)
        #expect(UInt.gcd(5, 0) == 5)
        #expect(UInt.gcd(0, 0) == 0)
        #expect(UInt.gcd(15, 15) == 15)
        #expect(UInt.gcd(100, 75) == 25)
        #expect(UInt.gcd(17, 13) == 1)
    }
}
