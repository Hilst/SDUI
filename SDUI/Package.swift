// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "SDUI",
		platforms: [
			.macOS(.v13),
			.iOS(.v16),
		],
    products: [
        .library( name: "SDUI", targets: ["SDUI"] ),
    ],
    targets: [
        .target(
					name: "SDUI",
					path: "Sources"
				),
        .testTarget(
					name: "SDUITests",
					dependencies: ["SDUI"],
					path: "Tests/SDUITests",
					resources: [
						.process("Mocks")
					]
				)
    ]
)
