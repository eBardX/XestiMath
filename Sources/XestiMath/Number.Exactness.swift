// © 2025 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Nested Types

    public enum Exactness {
        case exact
        case inexact
        case unspecified
    }
}

// MARK: - Sendable

extension Number.Exactness: Sendable {
}
