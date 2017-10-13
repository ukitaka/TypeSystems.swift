// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "TypeSystems",
    products: [
      .library(name: "Parsec", targets: ["Parsec"]),
      .library(name: "AlgorithmW", targets: ["AlgorithmW"]),
      .library(name: "Utils", targets: ["Utils"])
    ],
    targets: [
      .target(name: "Parsec", dependencies: []),
      .target(name: "AlgorithmW", dependencies: ["Utils"]),
      .target(name: "Utils", dependencies: []),
      .testTarget(name: "AlgorithmWTests", dependencies: ["AlgorithmW"]), 
      .testTarget(name: "UtilsTests", dependencies: ["Utils"]),
    ]
)

