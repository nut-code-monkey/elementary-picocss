// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "elementary-picocss",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(name: "PicoCSS", targets: ["PicoCSS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary.git", from: "0.7.1"),
    ],
    targets: [
        .target(
            name: "PicoCSS",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
            ]
        ),
        .testTarget(
            name: "PicoCSSTests",
            dependencies: ["PicoCSS"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
