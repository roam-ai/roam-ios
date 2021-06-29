// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
   name: "Raom",
   products: [
       .library(
           name: "Roam",
           targets: ["Roam"]),
   ],
   targets: [
       .binaryTarget(
           name: "Roam",
           url: "Roam.xcframework.zip",
           checksum: "ae12720a239c78930e1a7b7b57b16fb92c4e100ca06cfde91ab36688a5f7c36f")
   ]
)