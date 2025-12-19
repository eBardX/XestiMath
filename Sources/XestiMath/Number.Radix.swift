// © 2025 John Gary Pusey (see LICENSE.md)

extension Number {

    // MARK: Public Nested Types

    public enum Radix: Int {
        case binary      = 2
        case decimal     = 10
        case hexadecimal = 16
        case octal       = 8
    }
}

// MARK: - Sendable

extension Number.Radix: Sendable {
}
