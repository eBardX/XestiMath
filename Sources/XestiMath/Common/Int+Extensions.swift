// © 2024 John Gary Pusey (see LICENSE.md)

extension Int {

    // MARK: Public Type Methods

    public static func modulo(_ n: Int,
                              _ m: Int) -> Int {
        let rem = n % m

        return rem != 0 && (n ^ m) < 0 ? rem + m : rem
    }
}
