// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

public struct RealFormatStyle {

    // MARK: Public Nested Types

    public typealias Configuration = NumberFormatStyleConfiguration

    // MARK: Public Initializers

    public init(locale: Locale = .autoupdatingCurrent) {
        self.locale = locale
    }

    // MARK: Public Instance Properties

    public let locale: Locale

    // public var attributed: RealFormatStyle.Attributed {
    // }

    // MARK: Public Instance Methods

    public func decimalSeparator(strategy: Configuration.DecimalSeparatorDisplayStrategy) -> Self {
        self
    }

    public func grouping(_ group: Configuration.Grouping) -> Self {
        self
    }

    public func notation(_ notation: Configuration.Notation) -> Self {
        self
    }

    public func precision(_ precision: Configuration.Precision) -> Self {
        self
    }

    public func rounded(rule: Configuration.RoundingRule = .toNearestOrEven,
                        increment: Double? = nil) -> Self {
        self
    }

    public func scale(_ multiplicand: Double) -> Self {
        self
    }

    public func sign(strategy: Configuration.SignDisplayStrategy) -> Self {
        self
    }
}

// MARK:  - FormatStyle

extension RealFormatStyle: FormatStyle {
    public func format(_ value: Real) -> String {
        ""
    }

    public func locale(_ locale: Locale) -> Self {
        self
    }
}

// MARK:  -

extension RealFormatStyle {
    public struct Attributed: FormatStyle {

        // MARK: Public Instance Methods

        public func format(_ value: Real) -> AttributedString {
            .init()
        }

        public func locale(_ locale: Locale) -> Self {
            self
        }
    }
}

// MARK:  -

extension FormatStyle where Self == RealFormatStyle {

    // MARK: Public Type Properties

    public static var number: RealFormatStyle {
        .init()
    }
}

// MARK:  -

extension Real {

    // MARK: Public Instance Methods

    public func formatted() -> String {
        ""
    }

    // public func formatted<S>(_ format: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle

    // public func formatted<S>(_ format: S) -> S.FormatOutput where S: FormatStyle, S.FormatInput: Real
}
