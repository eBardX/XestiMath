// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
import Testing
@testable import XestiMath

struct NumberFormatStyleAttributedTests {   // swiftlint:disable:this type_body_length
    @Test
    func test_format_complex() {
        let fs = Number.FormatStyle(minimumDecimalDigits: 1,
                                    maximumDecimalDigits: 3).attributed

        #expect(fs.format(Number(realPart: 123, imaginaryPart: 4_567)) ==
                _xp("123", .realPart) +
                _xs("+", .sign) +
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "567",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
        #expect(fs.format(Number(realPart: -123, imaginaryPart: 4_567)) ==
                _xs("-", .sign) +
                _xp("123", .realPart) +
                _xs("+", .sign) +
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "567",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
        #expect(fs.format(Number(realPart: 123.0, imaginaryPart: 4_567)) ==
                _xp(_xp("123", .integer) +
                    _xs(".", .decimalSeparator) +
                    _xp("0", .decimal), .realPart) +
                _xs("+", .sign) +
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "567" +
                    _xs(".", .decimalSeparator) +
                    "0",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
        #expect(fs.format(Number(realPart: -123.0, imaginaryPart: 4_567)) ==
                _xs("-", .sign) +
                _xp(_xp("123", .integer) +
                    _xs(".", .decimalSeparator) +
                    _xp("0", .decimal), .realPart) +
                _xs("+", .sign) +
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "567" +
                    _xs(".", .decimalSeparator) +
                    "0",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
        #expect(fs.format(Number(realPart: 1_234, imaginaryPart: 0)) ==
                _xp("1" +
                    _xs(",", .groupingSeparator) +
                    "234",
                    .realPart) +
                _xs("+", .sign) +
                _xp("0",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
        #expect(fs.format(Number(realPart: 1_234, imaginaryPart: -1)) ==
                _xp("1" +
                    _xs(",", .groupingSeparator) +
                    "234",
                    .realPart) +
                _xs("-", .sign) +
                _xp("1",
                    .imaginaryPart) +
                _xs("i", .imaginaryUnit))
    }

    @Test
    func test_format_exactInteger() {
        let fs = Number.FormatStyle().attributed

        #expect(fs.format(123) == "123")
        #expect(fs.format(1_234) ==
                "1" +
                _xs(",", .groupingSeparator) +
                "234")
        #expect(fs.format(5_836_472) ==
                "5" +
                _xs(",", .groupingSeparator) +
                "836" +
                _xs(",", .groupingSeparator) +
                "472")
        #expect(fs.format(-5_836_472) ==
                _xs("-", .sign) +
                "5" +
                _xs(",", .groupingSeparator) +
                "836" +
                _xs(",", .groupingSeparator) +
                "472")
        #expect(fs.format("12345678901234567890123456789012345678901234567890") ==
                "12" +
                _xs(",", .groupingSeparator) +
                "345" +
                _xs(",", .groupingSeparator) +
                "678" +
                _xs(",", .groupingSeparator) +
                "901" +
                _xs(",", .groupingSeparator) +
                "234" +
                _xs(",", .groupingSeparator) +
                "567" +
                _xs(",", .groupingSeparator) +
                "890" +
                _xs(",", .groupingSeparator) +
                "123" +
                _xs(",", .groupingSeparator) +
                "456" +
                _xs(",", .groupingSeparator) +
                "789" +
                _xs(",", .groupingSeparator) +
                "012" +
                _xs(",", .groupingSeparator) +
                "345" +
                _xs(",", .groupingSeparator) +
                "678" +
                _xs(",", .groupingSeparator) +
                "901" +
                _xs(",", .groupingSeparator) +
                "234" +
                _xs(",", .groupingSeparator) +
                "567" +
                _xs(",", .groupingSeparator) +
                "890")
        #expect(fs.format("-12345678901234567890123456789012345678901234567890") ==
                _xs("-", .sign) +
                "12" +
                _xs(",", .groupingSeparator) +
                "345" +
                _xs(",", .groupingSeparator) +
                "678" +
                _xs(",", .groupingSeparator) +
                "901" +
                _xs(",", .groupingSeparator) +
                "234" +
                _xs(",", .groupingSeparator) +
                "567" +
                _xs(",", .groupingSeparator) +
                "890" +
                _xs(",", .groupingSeparator) +
                "123" +
                _xs(",", .groupingSeparator) +
                "456" +
                _xs(",", .groupingSeparator) +
                "789" +
                _xs(",", .groupingSeparator) +
                "012" +
                _xs(",", .groupingSeparator) +
                "345" +
                _xs(",", .groupingSeparator) +
                "678" +
                _xs(",", .groupingSeparator) +
                "901" +
                _xs(",", .groupingSeparator) +
                "234" +
                _xs(",", .groupingSeparator) +
                "567" +
                _xs(",", .groupingSeparator) +
                "890")
    }

    @Test
    func test_format_floatingPoint() {
        let fs = Number.FormatStyle(minimumDecimalDigits: 1,
                                    maximumDecimalDigits: 3).attributed

        #expect(fs.format(123.0) ==
                _xp("123", .integer) +
                _xs(".", .decimalSeparator) +
                _xp("0", .decimal))
        #expect(fs.format(1_234.25) ==
                _xp("1" +
                    _xs(",", .groupingSeparator) +
                    "234",
                    .integer) +
                _xs(".", .decimalSeparator) +
                _xp("25", .decimal))
        #expect(fs.format(5_836_472.375) ==
                _xp("5" +
                    _xs(",", .groupingSeparator) +
                    "836" +
                    _xs(",", .groupingSeparator) +
                    "472",
                    .integer) +
                _xs(".", .decimalSeparator) +
                _xp("375", .decimal))
        #expect(fs.format(-5_836_472.6125) ==
                _xs("-", .sign) +
                _xp("5" +
                    _xs(",", .groupingSeparator) +
                    "836" +
                    _xs(",", .groupingSeparator) +
                    "472",
                    .integer) +
                _xs(".", .decimalSeparator) +
                _xp("613", .decimal))
        #expect(fs.format(.pi) ==
                _xp("3", .integer) +
                _xs(".", .decimalSeparator) +
                _xp("142", .decimal))
        #expect(fs.format(.nan) == _xp("NaN", .integer))
        #expect(fs.format(.positiveInfinity) == _xp("∞", .integer))
        #expect(fs.format(.negativeInfinity) ==
                _xs("-", .sign) +
                _xp("∞", .integer))
    }

    @Test
    func test_format_fraction() {
        let fs1 = Number.FormatStyle().attributed
        let fs2 = Number.FormatStyle(alwaysDisplaysDenominator: true).attributed
        let fs3 = Number.FormatStyle(minimumDecimalDigits: 0,
                                     maximumDecimalDigits: 3,
                                     displaysFractionAsDecimal: true).attributed

        #expect(fs1.format(Number(numerator: 123, denominator: 4_567)) ==
                _xp("123", .numerator) +
                _xs("/", .fractionBar) +
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "567",
                    .denominator))
        #expect(fs1.format(Number(numerator: 1_234, denominator: 56_789)) ==
                _xp("1" +
                    _xs(",", .groupingSeparator) +
                    "234",
                    .numerator) +
                _xs("/", .fractionBar) +
                _xp("56" +
                    _xs(",", .groupingSeparator) +
                    "789",
                    .denominator))
        #expect(fs1.format(Number(numerator: 4_012, denominator: 1)) ==
                "4" +
                _xs(",", .groupingSeparator) +
                "012")
        #expect(fs1.format(Number(numerator: -583, denominator: 6_472)) ==
                _xs("-", .sign) +
                _xp("583",
                    .numerator) +
                _xs("/", .fractionBar) +
                _xp("6" +
                    _xs(",", .groupingSeparator) +
                    "472",
                    .denominator))
        #expect(fs1.format("-12345678901234567890123456789012345678901234567890/977") ==
                _xs("-", .sign) +
                _xp("12" +
                    _xs(",", .groupingSeparator) +
                    "345" +
                    _xs(",", .groupingSeparator) +
                    "678" +
                    _xs(",", .groupingSeparator) +
                    "901" +
                    _xs(",", .groupingSeparator) +
                    "234" +
                    _xs(",", .groupingSeparator) +
                    "567" +
                    _xs(",", .groupingSeparator) +
                    "890" +
                    _xs(",", .groupingSeparator) +
                    "123" +
                    _xs(",", .groupingSeparator) +
                    "456" +
                    _xs(",", .groupingSeparator) +
                    "789" +
                    _xs(",", .groupingSeparator) +
                    "012" +
                    _xs(",", .groupingSeparator) +
                    "345" +
                    _xs(",", .groupingSeparator) +
                    "678" +
                    _xs(",", .groupingSeparator) +
                    "901" +
                    _xs(",", .groupingSeparator) +
                    "234" +
                    _xs(",", .groupingSeparator) +
                    "567" +
                    _xs(",", .groupingSeparator) +
                    "890",
                    .numerator) +
                _xs("/", .fractionBar) +
                _xp("977",
                    .denominator))
        #expect(fs2.format(Number(numerator: 4_012, denominator: 1)) ==
                _xp("4" +
                    _xs(",", .groupingSeparator) +
                    "012",
                    .numerator) +
                _xs("/", .fractionBar) +
                _xp("1", .denominator))
        #expect(fs3.format(Number(numerator: 4_012, denominator: 9)) ==
                _xp("445", .integer) +
                _xs(".", .decimalSeparator) +
                _xp("778", .decimal))
        #expect(fs3.format(Number(numerator: 4_012, denominator: 4)) ==
                "1" +
                _xs(",", .groupingSeparator) +
                "003")
    }
}

// MARK: -

extension NumberFormatStyleAttributedTests {
    private func _xp(_ val: AttributedString,
                     _ attr: XNumberPart) -> AttributedString {
        var copy = val

        copy.xnumberPart = attr

        return copy
    }

    private func _xp(_ val: String,
                     _ attr: XNumberPart) -> AttributedString {
        AttributedString(val,
                         attributes: AttributeContainer.xnumberPart(attr))
    }

    private func _xs(_ val: String,
                     _ attr: XNumberSymbol) -> AttributedString {
        AttributedString(val,
                         attributes: AttributeContainer.xnumberSymbol(attr))
    }
}

// swiftlint:disable:next static_operator
private func + (_ val1: AttributedString,
                _ val2: String) -> AttributedString {
    val1 + AttributedString(val2)
}

// swiftlint:disable:next static_operator
private func + (_ val1: String,
                _ val2: AttributedString) -> AttributedString {
    AttributedString(val1) + val2
}
