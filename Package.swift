// swift-tools-version: 6.2

// © 2025–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiMath",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiMath",
                                          targets: ["XestiMath"])],
                      dependencies: [.package(url: "https://github.com/attaswift/BigInt.git",
                                              .upToNextMajor(from: "5.7.0")),
                                     .package(url: "https://github.com/swiftlang/swift-docc-plugin.git",
                                              .upToNextMajor(from: "1.1.0")),
                                     .package(url: "https://github.com/apple/swift-numerics",
                                              .upToNextMajor(from: "1.1.0")),
                                     .package(url: "https://github.com/eBardX/XestiTools.git",
                                              .upToNextMajor(from: "7.2.0"))],
                      targets: [.target(name: "XestiMath",
                                        dependencies: [.product(name: "BigInt",
                                                                package: "BigInt"),
                                                       .product(name: "Numerics",
                                                                package: "swift-numerics"),
                                                       .product(name: "XestiTools",
                                                                package: "XestiTools")]),
                                .testTarget(name: "XestiMathTests",
                                            dependencies: [.target(name: "XestiMath")])],
                      swiftLanguageModes: [.v6])

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

for target in package.targets {
    var settings = target.swiftSettings ?? []

    settings.append(contentsOf: swiftSettings)

    target.swiftSettings = settings
}
