// © 2025 John Gary Pusey (see LICENSE.md)

import Foundation

extension AttributedString {

    // MARK: Internal Instance Methods

    internal mutating func replaceFoundationAttributes() {
        _replaceAttributes(.integer, .integer)
        _replaceAttributes(.fraction, .decimal)

        _replaceAttributes(.decimalSeparator, .decimalSeparator)
        _replaceAttributes(.groupingSeparator, .groupingSeparator)
        _replaceAttributes(.sign, .sign)
    }

    // MARK: Private Nested Types

    private typealias NumberPart   = AttributeScopes.FoundationAttributes.NumberFormatAttributes.NumberPartAttribute.NumberPart
    private typealias NumberSymbol = AttributeScopes.FoundationAttributes.NumberFormatAttributes.SymbolAttribute.Symbol
    private typealias RealPart     = AttributeScopes.XestiMathAttributes.RealFormatAttributes.RealPartAttribute.RealPart
    private typealias RealSymbol   = AttributeScopes.XestiMathAttributes.RealFormatAttributes.RealSymbolAttribute.RealSymbol

    // MARK: Private Instance Methods

    private mutating func _replaceAttributes(_ srcAttr: NumberPart,
                                             _ dstAttr: RealPart) {
        replaceAttributes(AttributeContainer.numberPart(srcAttr),
                          with: AttributeContainer.realPart(dstAttr))
    }

    private mutating func _replaceAttributes(_ srcAttr: NumberSymbol,
                                             _ dstAttr: RealSymbol) {
        replaceAttributes(AttributeContainer.numberSymbol(srcAttr),
                          with: AttributeContainer.realSymbol(dstAttr))
    }
}
