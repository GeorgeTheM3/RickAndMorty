//
//  CharacterInfoViewModel.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class CharacterInfoViewModel {
    let selectedCharacter: ResultCharacter
    
    init() {
        selectedCharacter = StorageService.shared.getSelectedCharacter()
    }
}
