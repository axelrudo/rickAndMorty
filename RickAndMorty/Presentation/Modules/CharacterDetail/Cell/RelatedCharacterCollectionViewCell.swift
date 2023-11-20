//
//  RelatedCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by axel on 3/8/23.
//

import UIKit

class RelatedCharacterCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    var useCase: ImageUseCaseProtocol = ImageUseCase()
    var character: Character?
    let characterImageView = UIImageView(frame: CGRectMake(0, 0, 120, 120))

    // MARK: - Functions
    func display(this character: Character) {
        addSubview(characterImageView)

        self.character = character
        setupView()
        setImage()

    }

    private func setupView() {
        characterImageView.layer.cornerRadius = characterImageView.frame.size.height / 2
    }

    private func setImage() {
        Task {
            let image = await useCase.load(from: character?.image ?? "")
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.characterImageView.image = image
            }
        }
    }
}
