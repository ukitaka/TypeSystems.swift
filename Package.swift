// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "TypeSystems",
    products: [
      .library(name: "Parsec", targets: ["Parsec"]),
      .library(name: "SwiftExistential", targets: ["SwiftExistential"]),
      .library(name: "AlgorithmW", targets: ["AlgorithmW"]),
      .library(name: "Fullsub", targets: ["Fullsub"]),
      .library(name: "Utils", targets: ["Utils"])
    ],
    targets: [
      .target(name: "Parsec", dependencies: ["Utils"]),
      .target(name: "SwiftExistential", dependencies: ["Parsec", "Utils"]),
      .target(name: "AlgorithmW", dependencies: ["Parsec", "Utils"]),
      .target(name: "Fullsub", dependencies: ["Parsec", "Utils"]),
      .target(name: "Utils", dependencies: []),
      .testTarget(name: "ParsecTests", dependencies: ["Parsec"]), 
      .testTarget(name: "SwiftExistentialTests", dependencies: ["SwiftExistential"]), 
      .testTarget(name: "AlgorithmWTests", dependencies: ["AlgorithmW"]), 
      .testTarget(name: "FullsubTests", dependencies: ["Fullsub"]), 
      .testTarget(name: "UtilsTests", dependencies: ["Utils"]),
    ]
)

