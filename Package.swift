// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CSVFileReader-Swift",
    products: [
        .library(
            name: "CSVFileReader-Swift",
            targets: ["CSVFileReader-Swift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CSVFileReader-Swift",
            dependencies: [],
            path: "Sources/CSVFileReader-Swift",
            exclude: ["Info.plist"]),
    ]
)
