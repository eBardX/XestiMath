// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

// MARK: Internal Types

internal typealias NumberPart    = AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart
internal typealias NumberSymbol  = AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol
internal typealias XNumberPart   = AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberPartAttribute.XNumberPart
internal typealias XNumberSymbol = AttributeScopes.XestiMathAttributes.XNumberFormatAttributes.XNumberSymbolAttribute.XNumberSymbol

extension AttributedString {

    // MARK: Internal Instance Methods

    internal mutating func replaceFoundationAttributes() {
        _replaceAttributes(.integer, .integer)
        _replaceAttributes(.fraction, .decimal)

        _replaceAttributes(.decimalSeparator, .decimalSeparator)
        _replaceAttributes(.groupingSeparator, .groupingSeparator)
        _replaceAttributes(.sign, .sign)
    }

    // MARK: Private Instance Methods

    private mutating func _replaceAttributes(_ srcAttr: NumberPart,
                                             _ dstAttr: XNumberPart) {
        replaceAttributes(AttributeContainer.numberPart(srcAttr),
                          with: AttributeContainer.xnumberPart(dstAttr))
    }

    private mutating func _replaceAttributes(_ srcAttr: NumberSymbol,
                                             _ dstAttr: XNumberSymbol) {
        replaceAttributes(AttributeContainer.numberSymbol(srcAttr),
                          with: AttributeContainer.xnumberSymbol(dstAttr))
    }
}
