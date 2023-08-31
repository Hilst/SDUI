import Foundation

public protocol Client: AnyObject {
	func request(complete: @escaping ((Result<Data, Error>) -> Void)) -> Void
}
public protocol Mapper: AnyObject {
	func getContent(from data: Data) -> Result<Content, Error>
}
typealias Renderer<T> = ((Content) -> T)
