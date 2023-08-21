//
//  MainView.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import UIKit
import Combine

final class MainView: UIViewController {
    private var cancellable = Set<AnyCancellable>()
    
    private let viewModel: MainViewModel
    
    private lazy var activitiIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemGreen
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50)
        return indicator
    }()
    
    private lazy var characterListCollectionView: UICollectionView = {
        let frame = self.view.frame
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: setCompositionLayout())
        collectionView.register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.reuseID)
        collectionView.prefetchDataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        bindings()
    }
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = MainViewModel()
        super.init(coder: coder)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Characters"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupView() {
        characterListCollectionView.backgroundColor = .myBackground
        self.view.addSubview(characterListCollectionView)
        self.view.addSubview(activitiIndicator)
    }
    
    private func checkList() {
        if !viewModel.charactersList.isEmpty {
            activitiIndicator.stopAnimating()
            characterListCollectionView.isHidden = false
        }
    }
    
    private func bindings() {
        viewModel.$charactersList
            .receive(on: RunLoop.main)
            .map { element -> [ResultCharacter] in
                return element
            }
            .sink { download in
                self.checkList()
                self.characterListCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseID, for: indexPath) as? PersonCell else { return UICollectionViewCell()}
        let info = viewModel.charactersList[indexPath.row]
        cell.backgroundColor = .myBackgroundCell
        cell.configureCell(with: info)
        cell.layer.cornerRadius = 16
        cell.clipsToBounds = true
        return cell
    }
}

extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCharacter(viewModel.charactersList[indexPath.row])
        viewModel.downloadEpisodesData()
        let controller = CharacterInfoView()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: SetCompositionLayout
extension MainView {
    private func setCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {_,_ in
            return self.storiesSectionLayout()
        }
        return layout
    }
    
    private func storiesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.55))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 20, bottom: 7, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

//MARK: UITableViewDataSourcePrefetching
extension MainView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // get max cell
        guard let maxCell = indexPaths.map({$0.row}).max() else { return }
        // and download more characters when need
        if maxCell > (viewModel.charactersList.count - 3){
            viewModel.downloadNextPage()
        }
    }
}
