//
//  NetwrokService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private let networkManager =  NetworkManager()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        bindigs()
    }
    
    func fetchCharacterData(page: Int = 1) {
        networkManager.fetchCharacterData(page: page)
    }
    
    func fetchEpisodesData() {
        let selectedChar = StorageService.shared.getSelectedCharacter()
        networkManager.fetchEpisodes(for: selectedChar)
    }
    
    private func bindigs() {
        networkManager.$downloadedCharacter
            .receive(on: RunLoop.main)
            .map { element -> ResultCharacter? in
                return element
            }
            .sink { download in
                if let char = download {
                    StorageService.shared.save(character: char)
                }
            }
            .store(in: &cancellable)
        
        networkManager.$episode
            .receive(on: RunLoop.main)
            .map { element -> EpisodeData? in
                return element
            }
            .sink { download in
                if let episode = download {
                    StorageService.shared.save(episode: episode)
                }
            }
            .store(in: &cancellable)
    }
    
}
