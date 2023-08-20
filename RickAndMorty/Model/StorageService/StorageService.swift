//
//  StorageService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class StorageService: StorageServiceProtocol {
    @Published var updateStorage: Bool = false
    @Published var updateEpisodes: Bool = false
    
    static let shared = StorageService()
    
    private var localStorage = LocalStorage()
    
    func getCharacterS() -> [ResultCharacter] {
        return localStorage.charectersStorage
    }
    
    func getEpisodes() -> [EpisodeData] {
        return localStorage.episodes
    }
    
    func clearEpisodes() {
        return localStorage.episodes.removeAll()
    }
    
    func selectCharecter(_ char: ResultCharacter) {
        localStorage.selectedCharacter = char
    }
    
    func getSelectedCharacter() -> ResultCharacter {
        return localStorage.selectedCharacter
    }
    
    func save(character: ResultCharacter) {
        localStorage.charectersStorage.append(character)
        updateStorage = true
    }
    
    func save(episode: EpisodeData) {
        localStorage.episodes.append(episode)
        updateEpisodes = true
    }
    
}
