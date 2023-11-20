//
//  FavoritesViewModel.swift
//  RickAndMorty
//
//  Created by axel on 9/8/23.
//  
//

import Foundation

protocol FavoritesViewModelProtocol: ViewModelProtocol {
    var characters: [Character] { get set }
    var didDataLoaded: (() -> Void)? { get set }
    var didResponseFailed: ((String) -> Void)? { get set }
    func goToCharacterDetail(of character: Int)
    func saveOrRemove(character: Character)
}

final class FavoritesViewModel {

    // MARK: - Properties
	private let router: FavoritesRouterProtocol
    private let useCase: CharacterUseCaseProtocol
    var characters = [Character]()
    var didDataLoaded: (() -> Void)?
    var didResponseFailed: ((String) -> Void)?

    // MARK: - Init
	required init(router: FavoritesRouterProtocol,
                  useCase: CharacterUseCaseProtocol) {
		self.router = router
        self.useCase = useCase
	}
}

// MARK: - Life cycle
extension FavoritesViewModel {

    func viewWillAppear() {
        loadCharacters()
    }
}

// MARK: - Functions
extension FavoritesViewModel: FavoritesViewModelProtocol {

    private func loadCharacters() {
        Task {
            do {
                characters = try await useCase.loadFavoriteCharacters()
                didDataLoaded?()
            } catch {
                didResponseFailed?(error.localizedDescription)
            }
        }
    }


    func saveOrRemove(character: Character) {
        Task {
            do {
                try await character.isFavorite ? useCase.saveCharacter(character: character) : useCase.removeCharacter(character: character)
                self.characters = try await useCase.loadUpdatedCharacters(characters: self.characters)
                self.characters = characters.filter { $0.isFavorite }
                didDataLoaded?()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func goToCharacterDetail(of character: Int) {
        router.characterDetail(of: characters[character])
    }
}
