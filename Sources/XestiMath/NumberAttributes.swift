// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension AttributeDynamicLookup {
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes, T>) -> T {
        self[T.self]
    }

    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes.XNumberFormatAttributes, T>) -> T {
        self[T.self]
    }
}

// MARK: -

extension AttributeScopes {
    public struct XestiMathAttributes: AttributeScope {
        public let xnumberFormat: XNumberFormatAttributes
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes {
    public struct XNumberFormatAttributes: AttributeScope {
        public let xnumberPart: XNumberPartAttribute
        public let xnumberSymbol: XNumberSymbolAttribute
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.XNumberFormatAttributes {
    public enum XNumberPartAttribute: CodableAttributedStringKey {
        public static let name = "XestiMath.XNumberFormatPart"
    }

    public enum XNumberSymbolAttribute: CodableAttributedStringKey {
        public static let name = "XestiMath.XNumberFormatSymbol"
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberPartAttribute {
    public enum XNumberPart: Int, Codable {
        case decimal
        case denominator
        case imaginaryPart
        case integer
        case numerator
        case realPart
    }

    public typealias Value = XNumberPart
}

// MARK: - Sendable (AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberPartAttribute.XNumberPart)

extension AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberPartAttribute.XNumberPart: Sendable {
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberSymbolAttribute {
    public enum XNumberSymbol: Int, Codable {
        case decimalSeparator
        case fractionBar
        case groupingSeparator
        case imaginaryUnit
        case sign
    }

    public typealias Value = XNumberSymbol
}

// MARK: - Sendable (AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberSymbolAttribute.XNumberSymbol)

extension AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberSymbolAttribute.XNumberSymbol: Sendable {
}
