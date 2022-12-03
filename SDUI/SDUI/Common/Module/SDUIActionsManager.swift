import Foundation

internal protocol SDUIActionsManagerProtocol {
    var viewModel: SDUIViewModel? { get set }

    func performAction(withSignature signature: String, andParameter parameter: Any?)
}

@objc
public final class SDUIActionsManager: NSObject, SDUIActionsManagerProtocol {

    public weak var viewModel: SDUIViewModel?

    public enum SDUIActionsErrors: Error {
        case invalidActionSignature(String)
    }

    internal func performAction(withSignature signature: String, andParameter parameter: Any? = nil) {
        var selector: Selector!

        do {
            selector = try self.getValidSelector(signature: signature)
        } catch SDUIActionsErrors.invalidActionSignature(let signature) {
            print("\n// =============================== //")
            print("There is no method with the following signature: \(signature)")
            print("\n// =============================== //\n")
            logAllMethodsAvaible()
            return
        } catch {
            print("\n// =============================== //")
            print("There was a error processing the following signature: \(signature)")
            print("\n// =============================== //\n")
            return
        }

        if let parameter: Any = parameter { self.perform(selector, with: parameter.self) }
        else { self.perform(selector) }
    }

    internal func logAllMethodsAvaible(with regex: String = "") {
        var count: UInt32 = 0
        guard
            let methods: UnsafeMutablePointer<Method> = class_copyMethodList(object_getClass(self), &count),
            count > 2
        else { return }

        print("\n// =============================== //")
        print("Avaible selectors on Actions Manager:\n")
        for method in UnsafeBufferPointer(start: methods, count: Int(count)) {
            let desciption: String = method_getName(method).description
            if isValidSignature(desciption), containRegex(desciption, regex: regex) {
                print(desciption)
            }
        }
        print("\n// =============================== //\n")
    }

    private func getValidSelector(signature: String) throws -> Selector {
        let selector = Selector(signature)
        guard self.responds(to: selector) else { throw SDUIActionsErrors.invalidActionSignature(signature) }
        return selector
    }

    private func isValidSignature(_ signature: String) -> Bool {
        if (["init", ".cxx_destruct"].contains(signature)) { return false }
        return true
    }

    private func containRegex(_ content: String, regex: String) -> Bool {
        if regex.isEmpty { return true }
        return content.lowercased().contains(regex.lowercased())
    }
}
