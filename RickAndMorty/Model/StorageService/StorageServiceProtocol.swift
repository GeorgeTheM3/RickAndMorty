//
//  StorageServiceProtocol.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

protocol StorageServiceProtocol {
    func saveCharacter(_ character: Character)
    func getCharacters() -> [Character]
}
