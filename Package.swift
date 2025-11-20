// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "roam-ios",
    products: [
        .library(
            name: "Roam",
            targets: ["Roam", "AWSAuthCore", "AWSCognitoIdentityProvider", "AWSCognitoIdentityProviderASF", "AWSCore", "AWSIoT", "AWSMobileClientXCF"]
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
            name: "AWSAuthCore",
            path: "Roam/AWSAuthCore.xcframework"),
        .binaryTarget(
            name: "AWSCognitoIdentityProvider",
            path: "Roam/AWSCognitoIdentityProvider.xcframework"),
        .binaryTarget(
            name: "AWSCognitoIdentityProviderASF",
            path: "Roam/AWSCognitoIdentityProviderASF.xcframework"),
        .binaryTarget(
            name: "AWSCore",
            path: "Roam/AWSCore.xcframework"),
        .binaryTarget(
            name: "AWSIoT",
            path: "Roam/AWSIoT.xcframework"),
        .binaryTarget(
            name: "AWSMobileClientXCF",
            path: "Roam/AWSMobileClientXCF.xcframework"),
        .binaryTarget(
            name: "RoamGeofence",
            path: "Roam/RoamGeofence.xcframework"),
    ]
)
