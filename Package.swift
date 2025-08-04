// swift-tools-version: 5.10

// © 2025 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiMath",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
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
                                                                package: "swift-numerics")]),
                                .testTarget(name: "XestiMathTests",
                                            dependencies: [.target(name: "XestiMath")])],
                      swiftLanguageVersions: [.v5])

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}
