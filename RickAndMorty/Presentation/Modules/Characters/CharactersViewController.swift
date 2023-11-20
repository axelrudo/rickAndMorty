//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by axel on 27/7/23.
//  
//

import UIKit

final class CharactersViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: CharactersViewModelProtocol!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewReady()

        setupBindings()
        setupUI()
        configure(this: tableView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    // MARK: - Functions
    private func setupBindings() {
        viewModel.didDataLoaded = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        viewModel.didResponseFailed = { [weak self] message in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showError(with: message)
            }
        }
    }

    private func setupUI() {
        navigationItem.title = "characters_title".localized
    }
}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func configure(this tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "CharactersTableViewCell",
                  bundle: Bundle(for: CharactersTableViewCell.self)),
            forCellReuseIdentifier: "CharactersTableViewCell"
        )
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell") as? CharactersTableViewCell else { return UITableViewCell() }

        cell.display(with: viewModel.characters[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadCharacters()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToCharacterDetail(of: indexPath.row)
    }
}

extension CharactersViewController: CharactersCellDelegate {
    func didPressFavoriteButton(for character: Character) {
        viewModel.saveOrRemove(character: character)
    }
}
