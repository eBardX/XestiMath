// © 2025–2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct IntExtensionsTests {
}

// MARK: -

extension IntExtensionsTests {
    @Test
    func test_modulo() {
        #expect(Int.modulo(7, 3) == 1)
        #expect(Int.modulo(-7, 3) == 2)
        #expect(Int.modulo(7, -3) == -2)
        #expect(Int.modulo(-7, -3) == -1)
        #expect(Int.modulo(0, 3) == 0)
        #expect(Int.modulo(6, 3) == 0)
        #expect(Int.modulo(1, 1) == 0)
        #expect(Int.modulo(10, 7) == 3)
        #expect(Int.modulo(-10, 7) == 4)
    }
}
