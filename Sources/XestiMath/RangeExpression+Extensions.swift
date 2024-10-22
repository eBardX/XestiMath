// © 2024 John Gary Pusey (see LICENSE.md)

extension RangeExpression {

    // MARK: Internal Instance Methods

    internal func clampedLowerAndUpperBounds(_ limits: Range<Int>) -> (lower: Int?, upper: Int?) {
        var lower: Int?
        var upper: Int?

        switch self {
        case let self as ClosedRange<Int>:
            let result = self.clamped(to: ClosedRange(limits))

            lower = result.lowerBound
            upper = result.upperBound

        case let self as PartialRangeFrom<Int>:
            lower = max(self.lowerBound,
                        limits.lowerBound)
            upper = nil

        case let self as PartialRangeThrough<Int>:
            lower = nil
            upper = min(self.upperBound,
                        limits.upperBound)

        case let self as PartialRangeUpTo<Int>:
            lower = nil

            let (value, overflow) = self.upperBound.subtractingReportingOverflow(1)

            if overflow {
                upper = min(self.upperBound,
                            limits.upperBound)
            } else {
                upper = min(value, limits.upperBound)
            }

        case let self as Range<Int>:
            let result = self.clamped(to: limits)

            lower = result.lowerBound
            upper = result.upperBound

        default:
            lower = nil
            upper = nil
        }

        if let tmpLower = lower {
            lower = min(tmpLower,
                        limits.upperBound)
        }

        if let tmpUpper = upper {
            upper = max(tmpUpper,
                        limits.lowerBound)
        }

        return (lower: lower,
                upper: upper)
    }
}
