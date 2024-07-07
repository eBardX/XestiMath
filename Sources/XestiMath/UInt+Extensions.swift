// © 2024 John Gary Pusey (see LICENSE.md)

extension UInt {

    // MARK: Public Type Methods

    public static func gcd(_ n1: UInt,
                           _ n2: UInt) -> UInt {
        var val1 = n1
        var val2 = n2

        while val2 != 0 {
            (val1, val2) = (val2, val1 % val2)
        }

        return val1
    }
}
