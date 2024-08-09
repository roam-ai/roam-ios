// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "roam-ios",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Roam",
            targets: ["Roam", "AWSAuthCore", "AWSCognitoIdentityProvider", "AWSCognitoIdentityProviderASF", "AWSCore", "AWSIoT", "AWSMobileClientXCF"]
        ),
        .library(
            name: "RoamMQTTConnector",
            targets: ["RoamMQTTConnector"]
        ),
        .library(
            name: "RoamBatchConnector",
            targets: ["RoamBatchConnector"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/emqx/CocoaMQTT.git", from: "2.1.8"),
        .package(url: "https://github.com/leeway1208/MqttCocoaAsyncSocket.git", from: "1.0.8"),
        .package(url: "https://github.com/daltoniam/Starscream.git", .exact("4.0.4"))
    ],
    targets: [
        .binaryTarget(
            name: "Roam",
            path: "Roam/Roam.xcframework"
        ),
        .binaryTarget(
            name: "AWSAuthCore",
            path: "Roam/AWSAuthCore.xcframework"
        ),
        .binaryTarget(
            name: "AWSCognitoIdentityProvider",
            path: "Roam/AWSCognitoIdentityProvider.xcframework"
        ),
        .binaryTarget(
            name: "AWSCognitoIdentityProviderASF",
            path: "Roam/AWSCognitoIdentityProviderASF.xcframework"
        ),
        .binaryTarget(
            name: "AWSCore",
            path: "Roam/AWSCore.xcframework"
        ),
        .binaryTarget(
            name: "AWSIoT",
            path: "Roam/AWSIoT.xcframework"
        ),
        .binaryTarget(
            name: "AWSMobileClientXCF",
            path: "Roam/AWSMobileClientXCF.xcframework"
        ),
        .binaryTarget(
            name: "RoamBatchConnector",
            path: "Roam/RoamBatchConnector.xcframework"
        ),
        .binaryTarget(
            name: "RoamMQTTConnector",
            path: "Roam/RoamMQTTConnector.xcframework"
        ),
    ]
)
