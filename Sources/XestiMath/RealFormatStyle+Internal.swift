// © 2024 John Gary Pusey (see LICENSE.md)

import BigInt
import Foundation

extension RealFormatStyle {

    // MARK: Internal Instance Methods

    internal func formatBigInt(_ value: BigInt) -> String {
        ""
    }

    internal func formatDouble(_ value: Double) -> String {
        var fs = FloatingPointFormatStyle.localizedDouble(locale: locale)

        if alwaysDisplaysFloatingPointSeparator {
            fs = fs.decimalSeparator(strategy: .always)
        }

        if !displaysGrouping {
            fs = fs.grouping(.never)
        }

        return fs.format(value)
    }

    internal func formatFraction(_ value: Fraction) -> String {
        ""
    }

    internal func formatInt(_ value: Int) -> String {
        ""
    }
}
