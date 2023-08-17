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
        networkService.fetchCharacterData()
        bindings()
    }
    
    func selectCharacter(_ char: ResultCharacter) {
        StorageService.shared.selectCharecter(char)
    }
    
    func bindings() {
       networkService.$characters
            .receive(on: RunLoop.main)
            .map { element -> [ResultCharacter] in
                return element
            }
            .sink { download in
                self.charactersList = download
            }
            .store(in: &cancellable)
    }
}
