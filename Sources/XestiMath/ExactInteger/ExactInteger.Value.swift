// © 2025 John Gary Pusey (see LICENSE.md)

import BigInt

extension ExactInteger {

    // MARK: Internal Nested Types

    internal enum Value: Sendable {
        case large(BigInt)
        case small(Int)
    }
}

// MARK: - Hashable

extension ExactInteger.Value: Hashable {
}
