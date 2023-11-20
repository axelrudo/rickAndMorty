//
//  ImageUseCase.swift
//  RickAndMorty
//
//  Created by axel on 11/8/23.
//

import UIKit

protocol ImageUseCaseProtocol {
    func load(from path: String) async -> UIImage
}

final class ImageUseCase {
    private let repository: ImageRepositoryProtocol

    init(repository: ImageRepositoryProtocol = ImageRepository()) {
        self.repository = repository
    }
}

extension ImageUseCase: ImageUseCaseProtocol {
    func load(from path: String) async -> UIImage {
        if let image = repository.loadFromCache(for: path) {
            return image
        }
        if let image = try? await repository.load(from: path) {
            repository.save(image, for: path)
            return image
        } else {
            return UIImage(named: "placeholder") ?? UIImage()
        }
    }
}
