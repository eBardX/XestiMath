// © 2024 John Gary Pusey (see LICENSE.md)

extension Fraction {

    // MARK: Public Type Methods

    public static prefix func - (z: Self) -> Self {
        Self(-z.numerator,
             z.denominator,
             false)
    }

    public static func - (z1: Self,
                          z2: Self) -> Self {
        Self((z1.numerator * z2.denominator) - (z1.denominator * z2.numerator),
             z1.denominator * z2.denominator,
             true)
    }

    public static func * (z1: Self,
                          z2: Self) -> Self {
        Self(z1.numerator * z2.numerator,
             z1.denominator * z2.denominator,
             true)
    }

    public static func / (z1: Self,
                          z2: Self) -> Self {
        Self(z1.numerator * z2.denominator,
             z1.denominator * z2.numerator,
             true)
    }

    public static func + (z1: Self,
                          z2: Self) -> Self {
        Self((z1.numerator * z2.denominator) + (z1.denominator * z2.numerator),
             z1.denominator * z2.denominator,
             true)
    }

    public static func < (x1: Self,
                          x2: Self) -> Bool {
        (x1.numerator * x2.denominator) < (x1.denominator * x2.numerator)
    }

    public static func == (z1: Self,
                           z2: Self) -> Bool {
        (z1.numerator == z2.numerator) && (z1.denominator == z2.denominator)
    }
}
