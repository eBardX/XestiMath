// © 2026 John Gary Pusey (see LICENSE.md)

extension Double {

    // MARK: Public Type Methods

    public static func convertToFraction(_ x: Double) -> (numerator: Int, denominator: Int) {
        //
        // Adapted from https://github.com/kevinboone/rationalize
        //
        precondition(x.isFinite,
                     "double value must be finite")

        let (xmag, xneg) = x < 0 ? (-x, true) : (x, false)
        let origValue = Int(xmag * Double(scale))

        var (value, cfCoef) = (origValue, origValue / scale)
        var (num, prevNum) = (cfCoef, 1)
        var (den, prevDen) = (1, 0)

        var loopCount = 0

        while loopCount < order && (value - (cfCoef * scale)) != 0 {
            value = (scale * scale) / (value - (cfCoef * scale))
            cfCoef = value / scale

            (num, prevNum) = (prevNum + cfCoef * num, num)
            (den, prevDen) = (prevDen + cfCoef * den, den)

            guard den != 0,
                  abs(((num * scale) / den) - origValue) > 1
            else { break }

            loopCount += 1
        }

        if xneg {
            num = -num
        }

        return (num, den)
    }

    // MARK: Private Type Properties

    private static let order = 6
    private static let scale = 1_000_000    // 10^order
}
