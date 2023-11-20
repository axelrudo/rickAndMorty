//
//  ImageDataSource.swift
//  RickAndMorty
//
//  Created by axel on 11/8/23.
//

import UIKit

protocol ImageDataSourceProtocol {
    func load(from path: String) async throws -> UIImage
}

final class ImageDataSource {
    private let network: NetworkProtocol

    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
}

extension ImageDataSource: ImageDataSourceProtocol {
    func load(from path: String) async throws -> UIImage {
        try await network.loadImage(path: path)
    }
}
