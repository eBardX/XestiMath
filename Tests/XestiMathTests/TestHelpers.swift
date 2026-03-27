// © 2026 John Gary Pusey (see LICENSE.md)

extension Double {
    internal func isApproximatelyEqual(to other: Double,
                                       tolerance: Double = 1e-10) -> Bool {
        Swift.abs(self - other) < tolerance
    }
}
