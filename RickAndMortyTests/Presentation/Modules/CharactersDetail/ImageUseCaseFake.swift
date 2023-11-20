//
//  ImageUseCaseFake.swift
//  RickAndMortyTests
//
//  Created by axel on 21/8/23.
//

@testable import RickAndMorty
import UIKit

final class ImageUseCaseFake: ImageUseCaseProtocol {
    var networkError: NetworkError?

    func load(from path: String) async -> UIImage {
        return UIImage()
    }
}
