// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkKit",
            targets: ["NetworkKit"])
    ],
    dependencies: [
        .package(name: "AppProtocols", path: "../AppProtocols"),
        .package(url: "https://github.com/rubensmachion/Mocker", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkKit",
            dependencies: [
                .product(name: "AppProtocols", package: "AppProtocols")
            ]),
        .testTarget(
            name: "NetworkKitTests",
            dependencies: [
                "NetworkKit",
                .product(name: "Mocker", package: "Mocker")
            ]
        )
    ]
)
