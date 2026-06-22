// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DisintegrationEffect",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "DisintegrationEffect",
            targets: ["DisintegrationEffect"]
        ),
    ],
    targets: [
        .target(
            name: "DisintegrationEffect"
        ),
    ]
)
