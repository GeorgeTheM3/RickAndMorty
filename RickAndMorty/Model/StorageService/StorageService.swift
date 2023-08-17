//
//  StorageService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class StorageService: StorageServiceProtocol {
    static let shared = StorageService()
    
    private var localStorage = LocalStorage()
    
    func selectCharecter(_ char: ResultCharacter) {
        localStorage.selectedCharacter = char
    }
    
    func getSelectedCharacter() -> ResultCharacter {
        return localStorage.selectedCharacter
    }
}
