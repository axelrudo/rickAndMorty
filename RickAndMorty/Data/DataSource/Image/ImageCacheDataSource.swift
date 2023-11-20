//
//  ImageCacheDataSource.swift
//  RickAndMorty
//
//  Created by axel on 11/8/23.
//

import UIKit

protocol ImageCacheDataSourceProtocol {
    func load(for key: String) -> UIImage?
    func save(_ image: UIImage, for key: String)
}

final class ImageCacheDataSource {
    private let cache: CacheProtocol

    init(cache: CacheProtocol = Cache()) {
        self.cache = cache
    }
}

extension ImageCacheDataSource: ImageCacheDataSourceProtocol {
    func load(for key: String) -> UIImage? {
        cache.loadImage(for: key)
    }

    func save(_ image: UIImage, for key: String) {
        cache.saveImage(image, for: key)
    }
}
