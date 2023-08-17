//
//  NetwrokService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine

class NetworkService: NetworkServiceProtocol {
    @Published var characters: [ResultCharacter] = []
    
    private let networkManager =  NetworkManager()
    
    private var cancellable = Set<AnyCancellable>()
    
    func fetchCharacterData(page: Int = 1) {
        networkManager.fetchCharacterData(page: page)
        networkManager.$characters
            .receive(on: RunLoop.main)
            .map { element -> [ResultCharacter] in
                return element
            }
            .sink { download in
                self.characters = download
            }
            .store(in: &cancellable)
    }
}
