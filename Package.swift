// swift-tools-version:5.3
//
//  Package.swift
//  SDK
//
//  Created by Aliev Yuriy on 21.09.2021.
//

import PackageDescription

let package = Package(
    name: "PaymentSDK",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(name: "PaymentSDK", targets: ["PaymentSDK"]),
    ],
    targets: [
        .target(name: "PaymentSDK", path: "PaymentSDK")
    ],
    swiftLanguageVersions: [.v5]
)
