//
//  MainView.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import UIKit
import Combine

class MainView: UIViewController {
    private var cancellable = Set<AnyCancellable>()
    
    private let viewModel: MainViewModel
    
    private lazy var characterListCollectionView: UICollectionView = {
        let frame = self.view.frame
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: setCompositionLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    private func setupView() {
        self.view.addSubview(characterListCollectionView)
    }
    
    func bindings() {
        viewModel.$charactersList
            .receive(on: RunLoop.main)
            .map { element -> [ResultCharacter] in
                return element
            }
            .sink { download in
                self.characterListCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.charactersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

extension MainView {
    private func setCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {_,_ in
            return self.storiesSectionLayout()
        }
        return layout
    }
    
    private func storiesSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalWidth(0.6))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
