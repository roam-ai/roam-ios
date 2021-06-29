// swift-tools-version:5.3
import PackageDescription

let package = Package(
   name: "roam-ios",
   products: [
       .library(
           name: "roam-ios",
           targets: ["Roam"]),
   ],
   targets: [
       .binaryTarget(
           name: "Roam",
           path: "Roam.xcframework.zip")
   ]
)