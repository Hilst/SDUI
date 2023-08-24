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
				.library( name: "SDUIModels", targets: ["SDUIModels"] )
    ],
    targets: [
        .target(
					name: "SDUI",
					dependencies: ["SDUIModels"],
					path: "Sources/SDUI"
				),
				.target(
					name: "SDUIModels",
					path: "Sources/Models"
				),
        .testTarget(
					name: "SDUITests",
					dependencies: ["SDUI", "SDUIModels"],
					resources: [
						.process("Mocks")
					]
				)
    ]
)
