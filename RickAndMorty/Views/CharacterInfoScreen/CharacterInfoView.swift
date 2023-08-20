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
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.reuseID)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseID)
        tableView.register(OriginCell.self, forCellReuseIdentifier: OriginCell.reuseID)
        tableView.register(CharacterInfoHeader.self, forHeaderFooterViewReuseIdentifier: CharacterInfoHeader.reuseId)
        tableView.register(SimpleHeader.self, forHeaderFooterViewReuseIdentifier: SimpleHeader.reuseId)
        tableView.separatorStyle = .none
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
        navigationController?.navigationBar.tintColor = .white
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
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseID, for: indexPath) as? InfoCell else { return UITableViewCell()}
            cell.backgroundColor = .myBackground
            cell.selectionStyle = .none
            cell.configureCell(with: viewModel.selectedCharacter)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OriginCell.reuseID, for: indexPath) as? OriginCell else { return UITableViewCell()}
            cell.backgroundColor = .myBackground
            cell.selectionStyle = .none
            cell.configureCell(with: viewModel.selectedCharacter)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseID, for: indexPath) as? EpisodeCell else { return UITableViewCell()}
            cell.backgroundColor = .myBackground
            cell.selectionStyle = .none
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
        case 2:
            return 80
        case 3:
            return 103
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let standartHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimpleHeader.reuseId) as? SimpleHeader else { return nil}
        switch section {
        case 0:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CharacterInfoHeader.reuseId) as? CharacterInfoHeader else { return nil}
            header.configureHeader(with: viewModel.selectedCharacter)
            return header
        case 1:
            standartHeader.configureHeader(with: "Info")
            return standartHeader
        case 2:
            standartHeader.configureHeader(with: "Origin")
            return standartHeader
        case 3:
            standartHeader.configureHeader(with: "Episode")
            return standartHeader
        default:
            return standartHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 250
        default:
            return 40
        }
    }
}
