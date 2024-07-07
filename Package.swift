// swift-tools-version:5.10

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiMath",
                      platforms: [.iOS(.v16),
                                  .macOS(.v13)],
                      products: [.library(name: "XestiMath",
                                          targets: ["XestiMath"])],
                      dependencies: [.package(url: "https://github.com/attaswift/BigInt.git",
                                              from: "5.3.0"),
                                     .package(url: "https://github.com/apple/swift-numerics",
                                              from: "1.0.0")],
                      targets: [.target(name: "XestiMath",
                                        dependencies: [.product(name: "BigInt",
                                                                package: "BigInt"),
                                                       .product(name: "Numerics",
                                                                package: "swift-numerics")],
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiMathTests",
                                            dependencies: [.target(name: "XestiMath")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageVersions: [.version("5")])
