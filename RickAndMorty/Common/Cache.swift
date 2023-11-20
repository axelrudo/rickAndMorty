//
//  Cache.swift
//  RickAndMorty
//
//  Created by axel on 9/8/23.
//

import UIKit

protocol CacheProtocol {
    func load<T: Codable>(for key: String, of type: T.Type) async throws -> T?
    func save<T: Codable>(object: T, for key: String, of type: T.Type) async throws
    func loadImage(for key: String) -> UIImage?
    func saveImage(_ image: UIImage, for key: String)
}

final class Cache {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

extension Cache: CacheProtocol {
    func load<T: Codable>(for key: String, of type: T.Type) async throws -> T? {
        guard let savedData = userDefaults.object(forKey: key) as? Data else {
            return nil
        }

        guard let decodedData = try? JSONDecoder().decode(T.self, from: savedData) else {
            throw CacheError.decode
        }

        return decodedData
    }

    func save<T: Codable>(object: T, for key: String, of type: T.Type) async throws {
        guard let encodedData = try? JSONEncoder().encode(object) else {
            throw CacheError.encode
        }
        userDefaults.set(encodedData, forKey: key)
    }

    func loadImage(for key: String) -> UIImage? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return UIImage(data: data)
    }

    func saveImage(_ image: UIImage, for key: String) {
        let data = image.pngData()
        userDefaults.set(data, forKey: key)
    }
}

enum CacheError: Error {
    case encode, decode
}
