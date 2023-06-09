// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UtilHelper5",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UtilHelper5",
            targets: ["UtilHelper5"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/DevLifee/UtilHelper5", from: "1.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UtilHelper5",
            dependencies: []),
        .testTarget(
            name: "UtilHelper5Tests",
            dependencies: ["UtilHelper5"]),
    ]
)
