// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "roam-ios",
    products: [
        .library(
            name: "Roam",
            targets: ["Roam"]
        ),
        .library(
            name: "RoamGeofence",
            targets: ["RoamGeofence"]
        )
    ],
    dependencies: [
        // Add any additional dependencies here
    ],
    targets: [
        .binaryTarget(
            name: "Roam",
            path: "Roam/Roam.xcframework"),
        .binaryTarget(
            name: "RoamGeofence",
            path: "Roam/RoamGeofence.xcframework"),
    ]
)
