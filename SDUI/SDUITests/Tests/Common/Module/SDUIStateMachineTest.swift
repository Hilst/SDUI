import XCTest
import Combine
@testable import SDUI

class SDUIStateMachineTest: XCTestCase {

    var sut: SDUIStateMachine!
    var cancellables: Set<AnyCancellable>!

    let allEvents: [SDUIStateMachine.Event] = [
        .initiate,
        .loadData,
        .retry,
        .failure,
        .badData,
        .success,
        .react
    ]

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        cancellables = nil
    }

    func test_start_to_fetch() {
        sut = SDUIStateMachine(initialState: .start)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .fetch {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.initiate)
        wait(for: expectators, timeout: 1)
    }

    func test_start_to_any() {
        sut = SDUIStateMachine(initialState: .start)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .start {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.react)
        sut.tryEvent(.badData)
        sut.tryEvent(.failure)
        sut.tryEvent(.retry)
        sut.tryEvent(.loadData)
        sut.tryEvent(.success)
        wait(for: expectators, timeout: 1)
    }

    func test_fetch_to_load() {
        sut = SDUIStateMachine(initialState: .fetch)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .load {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.loadData)
        wait(for: expectators, timeout: 1)
    }

    func test_fetch_to_error() {
        sut = SDUIStateMachine(initialState: .fetch)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .error {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.badData)
        wait(for: expectators, timeout: 1)
    }

    func test_fetch_to_any() {
        sut = SDUIStateMachine(initialState: .fetch)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .start {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.react)
        sut.tryEvent(.failure)
        sut.tryEvent(.retry)
        sut.tryEvent(.success)
        sut.tryEvent(.initiate)
        wait(for: expectators, timeout: 1)
    }

    func test_load_to_present() {
        sut = SDUIStateMachine(initialState: .load)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .present {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.success)
        wait(for: expectators, timeout: 1)
    }

    func test_load_to_error() {
        sut = SDUIStateMachine(initialState: .load)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .error {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.failure)
        wait(for: expectators, timeout: 1)
    }

    func test_load_to_any() {
        sut = SDUIStateMachine(initialState: .load)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .load {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.react)
        sut.tryEvent(.retry)
        sut.tryEvent(.initiate)
        sut.tryEvent(.badData)
        sut.tryEvent(.loadData)
        wait(for: expectators, timeout: 1)
    }

    func test_present_to_fetch() {
        sut = SDUIStateMachine(initialState: .present)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .fetch {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.react)
        wait(for: expectators, timeout: 1)
    }

    func test_present_to_any() {
        sut = SDUIStateMachine(initialState: .present)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .present {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.retry)
        sut.tryEvent(.initiate)
        sut.tryEvent(.badData)
        sut.tryEvent(.loadData)
        sut.tryEvent(.failure)
        sut.tryEvent(.success)
        wait(for: expectators, timeout: 1)
    }

    func test_error_to_fetch() {
        sut = SDUIStateMachine(initialState: .error)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .fetch {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.retry)
        wait(for: expectators, timeout: 1)
    }

    func test_error_to_any() {
        sut = SDUIStateMachine(initialState: .error)

        var expectators: [XCTestExpectation] = []
        sut.statePublisher.sink { state in
            if state == .error {
                let expectator = XCTestExpectation()
                expectator.fulfill()
                expectators.append(expectator)
            } else {
                let expectator = XCTestExpectation()
                expectators.append(expectator)
            }
        }
        .store(in: &cancellables)

        sut.tryEvent(.initiate)
        sut.tryEvent(.badData)
        sut.tryEvent(.loadData)
        sut.tryEvent(.failure)
        sut.tryEvent(.success)
        sut.tryEvent(.react)
        wait(for: expectators, timeout: 1)
    }
}
