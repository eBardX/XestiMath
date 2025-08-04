// © 2025 John Gary Pusey (see LICENSE.md)

import RegexBuilder

extension Number {

    // MARK: Internal Type Properties

    internal static let cxBinValueP = Regex {
        Capture {
            binReal
        }
        "@"
        Capture {
            binReal
        }
    }

    internal static let cxBinValueR = Regex {
        Capture {
            Optionally {
                binReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    binUReal
                    special
                }
            }
        }
        "i"
    }

    internal static let cxDecValueP = Regex {
        Capture {
            decReal
        }
        "@"
        Capture {
            decReal
        }
    }

    internal static let cxDecValueR = Regex {
        Capture {
            Optionally {
                decReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    decUReal
                    special
                }
            }
        }
        "i"
    }

    internal static let cxHexValueP = Regex {
        Capture {
            hexReal
        }
        "@"
        Capture {
            hexReal
        }
    }

    internal static let cxHexValueR = Regex {
        Capture {
            Optionally {
                hexReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    hexUReal
                    special
                }
            }
        }
        "i"
    }

    internal static let cxOctValueP = Regex {
        Capture {
            octReal
        }
        "@"
        Capture {
            octReal
        }
    }

    internal static let cxOctValueR = Regex {
        Capture {
            Optionally {
                octReal
            }
        }
        Capture {
            sign
            Optionally {
                ChoiceOf {
                    octUReal
                    special
                }
            }
        }
        "i"
    }

    internal static let eiBinValue = Regex {
        Optionally {
            sign
        }
        binUInteger
    }

    internal static let eiDecValue = Regex {
        Optionally {
            sign
        }
        decUInteger
    }

    internal static let eiHexValue = Regex {
        Optionally {
            sign
        }
        hexUInteger
    }

    internal static let eiOctValue = Regex {
        Optionally {
            sign
        }
        octUInteger
    }

    internal static let fpDecValue = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                decUFloat
            }
            Regex {
                sign
                special
            }
        }
    }

    internal static let fracBinValue = Regex {
        Capture {
            Optionally {
                sign
            }
            binUInteger
        }
        "/"
        Capture {
            binUInteger
        }
    }

    internal static let fracDecValue = Regex {
        Capture {
            Optionally {
                sign
            }
            decUInteger
        }
        "/"
        Capture {
            decUInteger
        }
    }

    internal static let fracHexValue = Regex {
        Capture {
            Optionally {
                sign
            }
            hexUInteger
        }
        "/"
        Capture {
            hexUInteger
        }
    }

    internal static let fracOctValue = Regex {
        Capture {
            Optionally {
                sign
            }
            octUInteger
        }
        "/"
        Capture {
            octUInteger
        }
    }

    internal static let pfxExactness = Regex {
        "#"
        exactness
    }

    internal static let pfxRadix = Regex {
        "#"
        radix
    }

    // MARK: Private Type Properties

    private static let binReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                binUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    private static let decReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                decUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    private static let hexReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                hexUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    private static let octReal = Regex {
        ChoiceOf {
            Regex {
                Optionally {
                    sign
                }
                octUReal
            }
            Regex {
                sign
                special
            }
        }
    }

    private static let binUReal = Regex {
        binUInteger
        Optionally {
            "/"
            binUInteger
        }
    }

    private static let decUReal = Regex {
        ChoiceOf {
            Regex {
                decUInteger
                Optionally {
                    "/"
                    decUInteger
                }
            }
            decUFloat
        }
    }

    private static let hexUReal = Regex {
        hexUInteger
        Optionally {
            "/"
            hexUInteger
        }
    }

    private static let octUReal = Regex {
        octUInteger
        Optionally {
            "/"
            octUInteger
        }
    }

    private static let decSuffix = Regex {
        "e"
        Optionally {
            sign
        }
        decUInteger
    }

    private static let decUFloat = Regex {
        ChoiceOf {
            Regex {
                ChoiceOf {
                    Regex {
                        "."
                        decUInteger
                    }
                    Regex {
                        decUInteger
                        "."
                        Optionally {
                            decUInteger
                        }
                    }
                }
                Optionally {
                    decSuffix
                }
            }
            Regex {
                decUInteger
                decSuffix
            }
        }
    }

    private static let binUInteger = Regex {
        OneOrMore {
            binDigit
        }
    }

    private static let decUInteger = Regex {
        OneOrMore {
            decDigit
        }
    }

    private static let hexUInteger = Regex {
        OneOrMore {
            hexDigit
        }
    }

    private static let octUInteger = Regex {
        OneOrMore {
            octDigit
        }
    }

    private static let special = Regex {
        ChoiceOf {
            "inf"
            "nan"
        }
        ".0"
    }

    private static let binDigit: CharacterClass  = .anyOf("01")
    private static let decDigit: CharacterClass  = .anyOf("0123456789")
    private static let exactness: CharacterClass = .anyOf("ei")
    private static let hexDigit: CharacterClass  = .anyOf("0123456789abcdef")
    private static let octDigit: CharacterClass  = .anyOf("01234567")
    private static let radix: CharacterClass     = .anyOf("bdho")
    private static let sign: CharacterClass      = .anyOf("+-")
}
