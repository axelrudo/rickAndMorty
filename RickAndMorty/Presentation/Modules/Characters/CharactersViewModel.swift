//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//  
//

import Foundation

protocol CharactersViewModelProtocol: ViewModelProtocol {
    var characters: [Character] { get set }
    var didDataLoaded: (() -> Void)? { get set }
    var didResponseFailed: ((String) -> Void)? { get set }
    func loadCharacters()
    func saveOrRemove(character: Character)
    func goToCharacterDetail(of character: Int)
}

final class CharactersViewModel {

    // MARK: - Properties
	private let router: CharactersRouterProtocol
    private let useCase: CharacterUseCaseProtocol
    private var page: Int = 1
    private var pagination: Pagination<Character> = Pagination()

    var characters = [Character]()
    var didDataLoaded: (() -> Void)?
    var didResponseFailed: ((String) -> Void)?

    // MARK: - Init
	required init(router: CharactersRouterProtocol,
                  useCase: CharacterUseCaseProtocol) {
		self.router = router
        self.useCase = useCase
	}
}

// MARK: - Life cycle
extension CharactersViewModel {
    func viewReady() {
        loadCharacters()
    }

    func viewWillAppear() {
        loadUpdatedCharacters()
    }
}

// MARK: - Functions
extension CharactersViewModel: CharactersViewModelProtocol {
    func loadCharacters() {
        Task {
            if pagination.hasNextPage {
                do {
                    pagination = try await useCase.loadCharacters(of: page)
                    page += 1
                    characters.append(contentsOf: pagination.results)
                    didDataLoaded?()
                } catch {
                    didResponseFailed?(error.localizedDescription)
                }
            }
        }
    }

    private func loadUpdatedCharacters() {
        Task {
            do {
                characters = try await useCase.loadUpdatedCharacters(characters: self.characters)
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
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func goToCharacterDetail(of character: Int) {
        router.characterDetail(of: characters[character])
    }
}
