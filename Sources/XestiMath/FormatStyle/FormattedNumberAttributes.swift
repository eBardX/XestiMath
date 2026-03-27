// © 2025—2026 John Gary Pusey (see LICENSE.md)

public import Foundation

extension AttributeDynamicLookup {
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes, T>) -> T {
        self[T.self]
    }

    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes.FormattedNumberAttributes, T>) -> T {
        self[T.self]
    }
}

// MARK: -

extension AttributeScopes {
    public struct XestiMathAttributes: AttributeScope {
        public let formattedNumber: FormattedNumberAttributes
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes {
    public struct FormattedNumberAttributes: AttributeScope {
        public let separator: SeparatorAttribute
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.FormattedNumberAttributes {
    public enum SeparatorAttribute: CodableAttributedStringKey {
        public static let name = "XestiMath.Separator"
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.FormattedNumberAttributes.SeparatorAttribute {
    public enum Separator: Int, Codable {
        case complex
        case decimal
        case fraction
        case mixed
        case ratio
    }

    public typealias Value = Separator
}

// MARK: - Sendable (AttributeScopes.XestiMathAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator)

extension AttributeScopes.XestiMathAttributes.FormattedNumberAttributes.SeparatorAttribute.Separator: Sendable {
}
