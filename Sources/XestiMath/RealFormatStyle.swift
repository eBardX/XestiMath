// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

public struct RealFormatStyle {

    // MARK: Public Initializers

    public init(locale: Locale = .autoupdatingCurrent) {
        self.alwaysDisplaysFloatingPointSeparator = false
        self.alwaysDisplaysFractionSeparator = false
        self.displaysGrouping = true
        self.locale = locale
    }

    // MARK: Public Instance Properties

    public private(set) var alwaysDisplaysFloatingPointSeparator: Bool
    public private(set) var alwaysDisplaysFractionSeparator: Bool
    public private(set) var displaysGrouping: Bool
    public private(set) var locale: Locale
    // public private(set) var precision: Precision?
}

// MARK: -

extension RealFormatStyle {

    // MARK: Public Instance Methods

    public func alwaysDisplaysFloatingPointSeparator(_ on: Bool) -> Self {
        var copy = self

        copy.alwaysDisplaysFloatingPointSeparator = on

        return copy
    }

    public func alwaysDisplaysFractionSeparator(_ on: Bool) -> Self {
        var copy = self

        copy.alwaysDisplaysFractionSeparator = on

        return copy
    }

    public func displaysGrouping(_ on: Bool) -> Self {
        var copy = self

        copy.displaysGrouping = on

        return copy
    }

    public func locale(_ locale: Locale) -> Self {
        var copy = self

        copy.locale = locale

        return copy
    }
}

// MARK: - FormatStyle

extension RealFormatStyle: FormatStyle {
    public func format(_ value: Real) -> String {
        ""
    }
}

// MARK: -

 extension FormatStyle where Self == RealFormatStyle {

    // MARK: Public Type Properties

    public static var number: RealFormatStyle {
        .init()
    }
 }

// MARK: -

extension Real {

    // MARK: Public Instance Methods

    public func formatted() -> String {
        ""
    }

    // public func formatted<S>(_ format: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle

    // public func formatted<S>(_ format: S) -> S.FormatOutput where S: FormatStyle, S.FormatInput: Real
}
