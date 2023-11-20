//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by axel on 3/8/23.
//  
//

import UIKit

protocol CharacterDetailViewModelProtocol: ViewModelProtocol {
    var didDataLoaded: ((UIImage, Character) -> Void)? { get set }
    var didResponseFailed: ((String) -> Void)? { get set }
    var didExitView: ((Character) -> Void) { get set }
    var characters: [Character] { get }
}

final class CharacterDetailViewModel {

    // MARK: - Properties
    private let router: CharacterDetailRouterProtocol
    private let useCase: CharacterUseCaseProtocol
    private let imageUseCase: ImageUseCaseProtocol
    private var page: Int = 1

    private let character: Character
    private var pagination: Pagination<Character> = Pagination() {
        didSet {
            characters.append(contentsOf: pagination.results)
        }
    }

    var characters = [Character]()
    var didDataLoaded: ((UIImage, Character) -> Void)?
    var didResponseFailed: ((String) -> Void)?
    var didExitView: ((Character) -> Void)

    // MARK: - Init
    required init(router: CharacterDetailRouterProtocol,
                  useCase: CharacterUseCaseProtocol,
                  imageUseCase: ImageUseCaseProtocol,
                  character: Character,
                  didExitView: @escaping ((Character) -> Void)) {
        self.router = router
        self.character = character
        self.imageUseCase = imageUseCase
        self.useCase = useCase
        self.didExitView = didExitView
    }
}

// MARK: - Life cycle
extension CharacterDetailViewModel {
    func viewReady() {
        loadData()
    }
}

// MARK: - Functions
extension CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private func loadData() {
        Task {
            let image = await imageUseCase.load(from: character.image)
            if pagination.hasNextPage {
                do {
                    pagination = try await useCase.loadCharacters(of: page, with: character.name)
                    page += 1
                } catch {
                    didResponseFailed?(error.localizedDescription)
                }
            }
            didDataLoaded?(image, character)
        }
    }
}
