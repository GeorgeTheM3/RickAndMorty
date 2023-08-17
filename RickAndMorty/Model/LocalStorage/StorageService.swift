//
//  StorageService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class StorageService: StorageServiceProtocol {
    private var localStorage = LocalStorage()
    
    func saveCharacter(_ character: Character) {
        localStorage.charectersStorage.append(character)
    }
    
    func getCharacters() -> [Character] {
        return localStorage.charectersStorage
    }
}
