// swift-tools-version:4.0
// Generated automatically by Perfect Assistant 2
// Date: 2018-01-29 11:19:08 +0000
import PackageDescription

let package = Package(
	name: "Perfect-FCM-Server",
	products: [
		.library(name: "Perfect-FCM-Server", targets: ["Perfect-FCM-Server"])
	],
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", "3.0.0"..<"4.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-OAuth2.git", "3.0.0"..<"4.0.0")
	],
	targets: [
		.target(name: "Perfect-FCM-Server", dependencies: ["PerfectCURL", "OAuth2"]),
		.testTarget(name: "Perfect-FCM-ServerTests", dependencies: ["Perfect-FCM-Server"])
	]
)
