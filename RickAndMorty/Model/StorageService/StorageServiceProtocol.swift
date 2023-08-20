//
//  StorageServiceProtocol.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

protocol StorageServiceProtocol {
    func selectCharecter(_ char: ResultCharacter)
    func save(character: ResultCharacter)
    func save(episode: EpisodeData)
}
