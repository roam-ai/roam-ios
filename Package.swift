// swift-tools-version:5.3
import PackageDescription

let package = Package(
   name: "roam-ios",
   products: [
       .library(
           name: "roam-ios",
           targets: ["Roam", "AWSAuthCore", "AWSCognitoIdentityProvider", "AWSCognitoIdentityProviderASF", "AWSCore", "AWSIoT", "AWSMobileClientXCF"]),
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
           path: "Roam/AWSIoT.xcframework/"),
       .binaryTarget(
           name: "AWSMobileClientXCF",
           path: "Roam/AWSMobileClientXCF.xcframework"),
   ]
)