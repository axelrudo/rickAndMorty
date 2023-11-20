//
//  NetworkFake.swift
//  RickAndMortyTests
//
//  Created by axel on 28/7/23.
//

import UIKit
@testable import RickAndMorty

final class NetworkFake<R: Codable>: NetworkProtocol {

    var response: R?
    var networkError: NetworkError?

    func loadImage(path: String) async throws -> UIImage {
        if let networkError {
            throw networkError
        }

        return UIImage()
    }

    func load<T: Codable>(path: String, of type: T.Type) async throws -> T {
        if let networkError {
            throw networkError
        }

        if URL(string: path) == nil {
            throw NetworkError.badURL
        }

        if let response = response as? T {
            return response
        } else {
            throw NetworkError.parseError
        }
    }
}
