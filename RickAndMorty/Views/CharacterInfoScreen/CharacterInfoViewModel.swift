//
//  CharacterInfoViewModel.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine

final class CharacterInfoViewModel {
    @Published var episodes: [EpisodeData] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    let selectedCharacter: ResultCharacter
    
    init() {
        selectedCharacter = StorageService.shared.getSelectedCharacter()
        bindings()
    }
    
    private func bindings() {
        StorageService.shared.$updateEpisodes
            .sink(receiveValue: { _ in
                self.episodes = StorageService.shared.getEpisodes()
            })
            .store(in: &cancellable)
    }
    
    func clearEpisodes() {
        cancellable.removeAll()
        StorageService.shared.clearEpisodes()
    }
    
}
