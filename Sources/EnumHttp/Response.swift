import Foundation
import Combine

public struct Response {
    public let code: Int
    public let body: Data
    public let headers: [String: String]

    public static func make(data: Data, response urlResponse: URLResponse?) throws -> Response {
        guard
            let response = urlResponse as? HTTPURLResponse,
            let headers = response.allHeaderFields as? [String: String]
        else {
            throw URLError(.badServerResponse)
        }
        return Response(code: response.statusCode, body: data, headers: headers)
    }

    public func map<T: Decodable>(as type: T.Type, _ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        try decoder.decode(type, from: body)
    }
}

public extension AnyPublisher where Output == Response {
    func map<T: Decodable>(as type: T.Type, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
        return tryMap { try decoder.decode(type, from: $0.body) }.eraseToAnyPublisher()
    }
}
