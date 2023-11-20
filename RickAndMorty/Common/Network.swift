import UIKit

protocol NetworkProtocol {
    func load<T: Codable>(path: String,
                          of type: T.Type) async throws -> T
    func loadImage(path: String) async throws -> UIImage
}

final class Network: NetworkProtocol {

    func loadImage(path: String) async throws -> UIImage {
        guard let url = URL(string: path) else { throw NetworkError.badURL }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

        if let image = UIImage(data: data) {
            return image
        } else {
            throw NetworkError.parseError
        }
    }

    func load<T: Codable>(path: String,
                          of type: T.Type) async throws -> T {

        guard let url = URL(string: path) else { throw NetworkError.badURL }
        let (data, urlResponse) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard let response = urlResponse as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        do {
            return try parse(with: data, and: response, for: type)
        } catch {
            throw error
        }
    }

    private func parse<T: Codable>(with data: Data,
                                   and response: HTTPURLResponse,
                                   for type: T.Type) throws -> T {

        if (200..<300).contains(response.statusCode) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.parseError
            }
        } else {
            throw NetworkError.failure(statusCode: response.statusCode,
                                       data: data,
                                       response: response)
        }
    }
}

enum NetworkError: Error {
    case parseError
    case badRequest
    case badURL
    case failure(statusCode: Int, data: Data? = nil, response: URLResponse? = nil)
}
