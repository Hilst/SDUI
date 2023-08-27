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
				.library( name: "SDUIModels", targets: ["SDUIModels"] ),
				.library( name: "SDUIStateMachine", targets: ["SDUIStateMachine"] )
    ],
    targets: [
        .target(
					name: "SDUI",
					dependencies: ["SDUIModels", "SDUIStateMachine"],
					path: "Sources/SDUI"
				),
				.target(
					name: "SDUIModels",
					path: "Sources/Models"
				),
				.target(
					name: "SDUIStateMachine",
					dependencies: ["SDUIModels"],
					path: "Sources/SM"
				),
        .testTarget(
					name: "SDUITests",
					dependencies: ["SDUI", "SDUIModels", "SDUIStateMachine"],
					path: "Tests/SDUITests",
					resources: [
						.process("Mocks")
					]
				)
    ]
)
