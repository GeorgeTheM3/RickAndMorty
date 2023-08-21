//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine

final class MainViewModel: MainViewModelProtocol {
    @Published var charactersList: [ResultCharacter] = []
    
    private var downloadedPage: Int = 1
    
    private var cancellable = Set<AnyCancellable>()
    
    private let networkService = NetworkService()

    init() {
        self.networkService.fetchCharacterData()
        bindings()
    }
    
    func selectCharacter(_ char: ResultCharacter) {
        StorageService.shared.selectCharecter(char)
    }
    
    func downloadEpisodesData() {
        networkService.fetchEpisodesData()
    }
    
    func downloadNextPage() {
        downloadedPage += 1
        networkService.fetchCharacterData(page: downloadedPage)
    }
    
    private func bindings() {
        StorageService.shared.$updateStorage
            .sink(receiveValue: { _ in
                self.charactersList = StorageService.shared.getCharacterS()
            })
            .store(in: &cancellable)
    }
}
