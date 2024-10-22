// © 2024 John Gary Pusey (see LICENSE.md)

import Foundation

public struct RealFormatStyle {

    // MARK: Public Nested Types

    public typealias Configuration = RealFormatStyleConfiguration

    internal var collection: Configuration.Collection = Configuration.Collection()

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
        var copy = self
        
        copy.collection.decimalSeparatorStrategy = strategy
            
        return copy
    }

    public func grouping(_ group: Configuration.Grouping) -> Self {
        var copy = self
            
        copy.collection.group = group
            
        return copy
    }

    public func precision(_ precision: Configuration.Precision) -> Self {
        var copy = self

        copy.collection.precision = precision
        
        return copy
    }

//    public func rounded(rule: Configuration.RoundingRule = .toNearestOrEven,
//                        increment: Real? = nil) -> Self {
//        var copy = self
//            
//        copy.collection.rounding = rule
//            
//        if let increment {
//            copy.collection.roundingIncrement = .integer(value: increment)
//        }
//            
//        return copy
//    }

    public func sign(strategy: Configuration.SignDisplayStrategy) -> Self {
        var copy = self
        
        copy.collection.signDisplayStrategy = strategy
            
        return copy
    }
}

// MARK:  - FormatStyle

//extension RealFormatStyle: FormatStyle {
//    public func format(_ value: Real) -> String {
//        ""
//    }
//
//    public func locale(_ locale: Locale) -> Self {
//        var copy = self
//            
//        copy.locale = locale
//            
//        return copy
//    }
//}

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

//extension FormatStyle where Self == RealFormatStyle {
//
//    // MARK: Public Type Properties
//
//    public static var number: RealFormatStyle {
//        .init()
//    }
//}

// MARK:  -

extension Real {

    // MARK: Public Instance Methods

    public func formatted() -> String {
        ""
    }

    // public func formatted<S>(_ format: S) -> S.FormatOutput where Self == S.FormatInput, S: FormatStyle

    // public func formatted<S>(_ format: S) -> S.FormatOutput where S: FormatStyle, S.FormatInput: Real
}
