//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by axel on 3/8/23.
//  
//

import UIKit

final class CharacterDetailViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var keyboard: UITextField!
    // MARK: - Properties
    var viewModel: CharacterDetailViewModelProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel.viewReady()
    }

    // MARK: - Functions
    private func setupBindings() {
        viewModel.didDataLoaded = { [weak self] image, character in
            guard let self else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
                self.nameLabel.text = character.name
                self.speciesLabel.text = character.species
                self.configure(this: self.collectionView)
            }
        }

        viewModel.didResponseFailed = { [weak self] message in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showError(with: message)
            }
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func configure(this collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RelatedCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: "RelatedCharacterCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCharacterCollectionViewCell", for: indexPath) as? RelatedCharacterCollectionViewCell else { return UICollectionViewCell() }
        cell.display(this: viewModel.characters[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        viewModel.didExitView(viewModel.characters[indexPath.row])
    }
}
