// swift-tools-version:5.5
import PackageDescription

let package = Package(
   name: "roam-ios",
   products: [
       .library(
           name: "roam-ios",
           targets: ["Roam", "RMAWSAuthCore", "RMAWSCognitoIdentityProvider", "RMAWSCognitoIdentityProviderASF", "RMAWSCore", "RMAWSIoT", "RMAWSMobileClientXCF"]),
   ],
   targets: [
       .binaryTarget(
           name: "Roam",
           path: "Roam/Roam.xcframework"),
       .binaryTarget(
           name: "RMAWSAuthCore",
           path: "Roam/AWSAuthCore.xcframework"),
       .binaryTarget(
           name: "RMAWSCognitoIdentityProvider",
           path: "Roam/AWSCognitoIdentityProvider.xcframework"),
       .binaryTarget(
           name: "RMAWSCognitoIdentityProviderASF",
           path: "Roam/AWSCognitoIdentityProviderASF.xcframework"),
       .binaryTarget(
           name: "RMAWSCore",
           path: "Roam/AWSCore.xcframework"),
       .binaryTarget(
           name: "RMAWSIoT",
           path: "Roam/AWSIoT.xcframework/"),
       .binaryTarget(
           name: "RMAWSMobileClientXCF",
           path: "Roam/AWSMobileClientXCF.xcframework"),
   ]
)
