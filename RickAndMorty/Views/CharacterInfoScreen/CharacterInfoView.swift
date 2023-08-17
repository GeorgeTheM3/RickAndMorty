//
//  CharacterInfoView.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import UIKit

class CharacterInfoView: UIViewController {
    private let viewModel: CharacterInfoViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
    }
    
    init(viewModel: CharacterInfoViewModel = CharacterInfoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CharacterInfoViewModel()
        super.init(coder: coder)
    }
    
    private func setupNavigation() {
    }
    
    private func setupView() {
        tableView.backgroundColor = .myBackground
        self.view.addSubview(tableView)
    }
}

extension CharacterInfoView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseID, for: indexPath) as? InfoCell else { return UITableViewCell()}
            cell.configureCell(with: viewModel.selectedCharacter)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
    }
    
}

extension CharacterInfoView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 130
        default:
            return 30
        }
    }
}
