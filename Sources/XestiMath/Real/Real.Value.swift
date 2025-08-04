// © 2025 John Gary Pusey (see LICENSE.md)

extension Real {

    // MARK: Internal Nested Types

    internal enum Value: Sendable {
        case exactInteger(ExactInteger)
        case floatingPoint(Double)
        case fraction(Fraction)
    }
}

// MARK: - Hashable

extension Real.Value: Hashable {
}
