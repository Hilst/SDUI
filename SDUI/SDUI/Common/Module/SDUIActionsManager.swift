import Foundation

@objc
public final class SDUIActionsManager: NSObject {

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
        } catch {
            print("\n// =============================== //")
            print("There was a error processing the following signature: \(signature)")
            print("\n// =============================== //\n")
        }

        if
            selector != nil,
            let parameter: Any = parameter
        {
            self.perform(selector, with: parameter.self)
        } else {
            self.perform(selector)
        }
    }

    public func logAllMethodsAvaible(with regex: String = "") {
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
        guard (["init", ".cxx_destruct"].contains(signature)) else {
            return true
        }
        return false
    }

    private func containRegex(_ content: String, regex: String) -> Bool {
        if regex.isEmpty { return true }
        return content.lowercased().contains(regex.lowercased())
    }
}
