//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine

class MainViewModel: MainViewModelProtocol {
    @Published var charactersList: [ResultCharacter] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    private let networkService = NetworkService()

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.networkService.fetchCharacterData(page: 2)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.networkService.fetchCharacterData(page: 2)
        })
        networkService.fetchCharacterData()
        bindings()
    }
    
    func selectCharacter(_ char: ResultCharacter) {
        StorageService.shared.selectCharecter(char)
    }
    
    func downloadEpisodesData() {
        networkService.fetchEpisodesData()
    }
    
    func bindings() {
        StorageService.shared.$updateStorage
            .sink(receiveValue: { _ in
                self.charactersList = StorageService.shared.getCharacterS()
            })
            .store(in: &cancellable)
    }
}
