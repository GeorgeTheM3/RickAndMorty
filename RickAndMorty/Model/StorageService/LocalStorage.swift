//
//  LocalStorage.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class LocalStorage {
    var charectersStorage: [ResultCharacter] = []
    var selectedCharacter = ResultCharacter(id: 0, imageURL: "", name: "", species: "", gender: "", type: "", origin: Origin(name: ""), episode: [])
}
