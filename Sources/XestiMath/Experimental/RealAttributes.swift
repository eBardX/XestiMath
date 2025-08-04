// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension AttributeDynamicLookup {
    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes, T>) -> T {
        self[T.self]
    }

    public subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.XestiMathAttributes.RealFormatAttributes, T>) -> T {
        self[T.self]
    }
}

// MARK: -

extension AttributeScopes {
    public var ivor: XestiMathAttributes.Type { XestiMathAttributes.self }

    public struct XestiMathAttributes: AttributeScope {
        public let realFormat: RealFormatAttributes
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes {
    public struct RealFormatAttributes: AttributeScope {
        public let realPart: RealPartAttribute
        public let realSymbol: RealSymbolAttribute
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.RealFormatAttributes {
    public enum RealPartAttribute: CodableAttributedStringKey {
        public static let name = "XestiMath.RealFormatPart"
    }

    public enum RealSymbolAttribute: CodableAttributedStringKey {
        public static let name = "XestiMath.RealFormatSymbol"
    }
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.RealFormatAttributes.RealPartAttribute {
    public enum RealPart: Int, Codable {
        case decimal
        case denominator
        case integer
        case numerator
    }

    public typealias Value = RealPart
}

// MARK: -

extension AttributeScopes.XestiMathAttributes.RealFormatAttributes.RealSymbolAttribute {
    public enum RealSymbol: Int, Codable {
        case decimalSeparator
        case fractionBar
        case groupingSeparator
        case sign
    }

    public typealias Value = RealSymbol
}
