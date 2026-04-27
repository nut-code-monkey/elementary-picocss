// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PicoCSS",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PicoCSS",
            targets: ["PicoCSS"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/elementary-swift/elementary.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "PicoCSS",
            dependencies: [
//                .product(name: "Elementary", package: "elementary"),
            ]
        ),
        .testTarget(
            name: "PicoCSSTests",
            dependencies: ["PicoCSS"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
