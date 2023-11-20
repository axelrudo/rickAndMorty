//
//  ImageRepository.swift
//  RickAndMorty
//
//  Created by axel on 11/8/23.
//

import UIKit

protocol ImageRepositoryProtocol {
    func load(from path: String) async throws -> UIImage
    func loadFromCache(for key: String) -> UIImage?
    func save(_ image: UIImage, for key: String)
}

final class ImageRepository {
    private let dataSource: ImageDataSourceProtocol
    private let cache: ImageCacheDataSourceProtocol

    init(dataSource: ImageDataSourceProtocol = ImageDataSource(),
         cache: ImageCacheDataSourceProtocol = ImageCacheDataSource()) {
        self.dataSource = dataSource
        self.cache = cache
    }
}

extension ImageRepository: ImageRepositoryProtocol {
    func load(from path: String) async throws -> UIImage {
        try await dataSource.load(from: path)
    }

    func loadFromCache(for key: String) -> UIImage? {
        cache.load(for: key)
    }

    func save(_ image: UIImage, for key: String) {
        cache.save(image, for: key)
    }
}
