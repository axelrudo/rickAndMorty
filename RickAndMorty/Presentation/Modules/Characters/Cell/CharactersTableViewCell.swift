//
//  CharactersTableViewCell.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//

import UIKit

protocol CharactersCellDelegate {
    func didPressFavoriteButton(for character: Character)
}

class CharactersTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var favoriteButton: UIButton!

    // MARK: - Properties
    var useCase: ImageUseCaseProtocol = ImageUseCase()
    var character: Character!
    var delegate: CharactersCellDelegate?

    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()

        let margins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.cornerRadius = 8
    }
    
    func display(with character: Character) {
        self.character = character

        setupCell()
        setImage(from: character.image)

        nameLabel.text = character.name
        speciesLabel.text = character.species

    }

    private func setupCell() {
        characterImage.layer.cornerRadius = characterImage.frame.size.height / 2
        characterImage.layer.borderWidth = 5
        characterImage.layer.borderColor = character.status.color.cgColor

        stackView.layer.cornerRadius = characterImage.frame.size.height / 2
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = character.status.color.cgColor
        stackView.backgroundColor = character.status.color

        favoriteButton.setImage(UIImage(systemName: character.isFavorite ? "star.fill" : "star"), for: .normal)
    }

    private func setImage(from path: String) {
        Task {
            let image = await useCase.load(from: path)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.characterImage.image = image
            }
        }
    }

    @IBAction func didPressFavoriteButton(_ sender: Any) {
        character.isFavorite.toggle()
        favoriteButton.setImage(UIImage(systemName: character.isFavorite ? "star.fill" : "star"), for: .normal)
        delegate?.didPressFavoriteButton(for: character)
    }
}
