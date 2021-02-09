// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TheAnimation",
    //platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(name: "TheAnimation", targets: ["TheAnimation"])
    ],
    targets: [
        .target(
            name: "TheAnimation",
            path: "TheAnimation/Source"
        )
    ]
)
