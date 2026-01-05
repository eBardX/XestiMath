// © 2026 John Gary Pusey (see LICENSE.md)

import Testing
@testable import XestiMath

struct NumberFormatStyleTests {
}

// MARK: -

extension NumberFormatStyleTests {
    @Test
    func test_format_complex() {
        let fs = Number.FormatStyle(minimumDecimalDigits: 1,
                                    maximumDecimalDigits: 3)

        #expect(fs.format(Number(realPart: 123, imaginaryPart: 4_567)) == "123+4,567i")
        #expect(fs.format(Number(realPart: 123.0, imaginaryPart: 4_567)) == "123.0+4,567.0i")
        #expect(fs.format(Number(realPart: 1_234, imaginaryPart: 0)) == "1,234+0i")
        #expect(fs.format(Number(realPart: 1_234, imaginaryPart: -1)) == "1,234-1i")
    }

    @Test
    func test_format_floatingPoint() {
        let fs = Number.FormatStyle(minimumDecimalDigits: 1,
                                    maximumDecimalDigits: 3)

        #expect(fs.format(123.0) == "123.0")
        #expect(fs.format(1_234.25) == "1,234.25")
        #expect(fs.format(5_836_472.375) == "5,836,472.375")
        #expect(fs.format(-5_836_472.6125) == "-5,836,472.613")
        #expect(fs.format(.nan) == "NaN")
        #expect(fs.format(.pi) == "3.142")
        #expect(fs.format(.positiveInfinity) == "∞")
        #expect(fs.format(.negativeInfinity) == "-∞")
    }

    @Test
    func test_format_exactInteger() {
        let fs = Number.FormatStyle()

        #expect(fs.format(123) == "123")
        #expect(fs.format(1_234) == "1,234")
        #expect(fs.format(5_836_472) == "5,836,472")
        #expect(fs.format(-5_836_472) == "-5,836,472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890")
                == "12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890")
                == "-12,345,678,901,234,567,890,123,456,789,012,345,678,901,234,567,890")
    }

    @Test
    func test_format_fraction() {
        let fs1 = Number.FormatStyle()
        let fs2 = Number.FormatStyle(alwaysDisplaysDenominator: true)
        let fs3 = Number.FormatStyle(minimumDecimalDigits: 0,
                                     maximumDecimalDigits: 3,
                                     displaysFractionAsDecimal: true)

        #expect(fs1.format(Number(numerator: 123, denominator: 4_567)) == "123/4,567")
        #expect(fs1.format(Number(numerator: 1_234, denominator: 56_789)) == "1,234/56,789")
        #expect(fs1.format(Number(numerator: 4_012, denominator: 1)) == "4,012")
        #expect(fs1.format(Number(numerator: -583, denominator: 6_472)) == "-583/6,472")
        #expect(fs2.format(Number(numerator: 4_012, denominator: 1)) == "4,012/1")
        #expect(fs3.format(Number(numerator: 4_012, denominator: 9)) == "445.778")
        #expect(fs3.format(Number(numerator: 4_012, denominator: 4)) == "1,003")
    }
}
