//
//  Package.swift
//  PulseInsights
//
//  Created by long shen on 2024/11/23.
//  Copyright © 2024 Pulse Insights. All rights reserved.
//

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "PulseInsights",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "PulseInsights",
            targets: ["PulseInsights"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PulseInsights",
            dependencies: [],
            path: "PulseInsightLibrary",
            exclude: ["Info.plist"],
            resources: [
                .process("images.xcassets"),
                .process("*.xib")
            ]
        ),
        .testTarget(
            name: "PulseInsightsTests",
            dependencies: ["PulseInsights"],
            path: "PulseInsightLibraryTests",
            exclude: ["Info.plist"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
