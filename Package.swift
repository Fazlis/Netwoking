// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Netwoking",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Netwoking",
            targets: ["Netwoking"]
        ),
        .library(
            name: "Interfaces",
            targets: ["Interfaces"]
        ),
        .library(
            name: "Client",
            targets: ["Client"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Netwoking",
            dependencies: ["Interfaces"]
        ),
        .target(
            name: "Client",
            dependencies: ["Interfaces"]
        ),
        .target(
            name: "Interfaces",
            dependencies: []
        )
    ]
)
