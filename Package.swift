// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "XCEEntityManager",
    products: [
        .library(
            name: "XCEEntityManager",
            targets: [
                "XCEEntityManager"
            ]
        )
    ],
    targets: [
        .target(
            name: "XCEEntityManager",
            path: "Sources/Core"
        ),
        .testTarget(
            name: "XCEEntityManagerAllTests",
            dependencies: [
                "XCEEntityManager"
            ],
            path: "Tests/AllTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)