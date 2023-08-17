//
//  NetwrokServiceProtocol.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    var characters: [ResultCharacter] { get set }
    func fetchCharacterData(page: Int)
}
