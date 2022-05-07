import Foundation
import Combine

public protocol ProviderType {
    associatedtype Target: TargetType
}

public struct Provider<T: TargetType>: ProviderType {
    public typealias Target = T

    public let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request(_ api: Target) -> AnyPublisher<Response, Error> {
        session
            .dataTaskPublisher(for: api.request)
            .tryMap { try .make(data: $0.data, response: $0.response) }
            .eraseToAnyPublisher()
    }

    public func request(_ api: Target) async throws -> Response {
        let (data, response) = try await session.data(for: api.request, delegate: nil)
        return try .make(data: data, response: response)
    }
}
