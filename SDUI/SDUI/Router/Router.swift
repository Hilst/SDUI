import SwiftUI

final class Router: ObservableObject {

    private let navigation: Stack<Route>
    private let initialRoute: Route

    public init(initialRoute: Route) {
        self.navigation = Stack<Route>()
        self.initialRoute = initialRoute
        navigation.push(initialRoute)
    }

    public func goto(route: Route) {
        navigation.push(route)
    }

    public func goBack() {
        _ = navigation.pop()
    }

    public func current() -> Route {
        navigation.peek() ?? initialRoute
    }

    public func fullTrace() -> String {

        var fullTrace = ""
        let hold = Stack<Route>()

        while let route = navigation.pop() {
            fullTrace = fullTrace.isEmpty ? "" : "." + fullTrace
            fullTrace = route.rawValue + fullTrace
            hold.push(route)
        }

        while let route = hold.pop() {
            navigation.push(route)
        }

        return fullTrace
    }
}
