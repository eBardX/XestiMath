extension Number {

    // MARK: Public Nested Types

    public struct FractionDisplayStrategy {
        //
        // decimal:                             "-0.625", "3.141592", "5.0"
        // mixed(alwaysShowInteger: false):     "2 1/4", "-1 1/3", "1", "1/2", "-1/4"
        // mixed(alwaysShowInteger: true):      "2 1/4", "-1 1/3", "1", "0 1/2", "-0 1/4"
        // ratio:                               "9:4", "−4:3", "1:1"
        // simple(alwaysShowDenominator: false) "-1/2", "17/3", "-5", "2/3", "−3/4", "4/9", "9/4", "−4/3", "1"
        // simple(alwaysShowDenominator: true)  "-1/2", "17/3", "-5/1", "2/3", "−3/4", "4/9", "9/4", "−4/3", "1/1"
        //

        // MARK: Public Type Properties

        public static var decimal: Self {
            Self(format: .decimal,
                 useAlternate: false)
        }

        public static var ratio: Self {
            Self(format: .ratio,
                 useAlternate: false)
        }

        // MARK: Public Type Methods

        public static func mixed(alwaysShowInteger: Bool = false) -> Self {
            Self(format: .mixed,
                 useAlternate: alwaysShowInteger)
        }

        public static func simple(alwaysShowDenominator: Bool = true) -> Self {
            Self(format: .simple,
                 useAlternate: !alwaysShowDenominator)
        }

        // MARK: Internal Nested Types

        internal enum Format: Codable {
            case decimal
            case mixed
            case ratio
            case simple
        }

        // MARK: Internal Instance Properties

        internal let format: Format
        internal let useAlternate: Bool
    }
}

// MARK: - Codable

extension Number.FractionDisplayStrategy: Codable {
}

// MARK: - CustomStringConvertible

extension Number.FractionDisplayStrategy: CustomStringConvertible {
    public var description: String {
        switch format {
        case .decimal:
            "decimal"

        case .mixed:
            "mixed(alwaysShowInteger: \(useAlternate ? "true" : "false")"

        case .ratio:
            "ratio"

        case .simple:
            "simple(alwaysShowDenominator: \(useAlternate ? "false" : "true")"
        }
    }
}

// MARK: - Hashable

extension Number.FractionDisplayStrategy: Hashable {
}
