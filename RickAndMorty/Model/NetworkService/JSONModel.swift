//
//  JSONModel.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

struct Character: Decodable {
    let info: Info
    let results: [Result]
}

struct Info: Decodable {
    let next: String
    let prev: String?
}

struct Result: Decodable {
    let id: Int
    let image: String
    let name: String
    let species: String
    let gender: String
    let type: String
    let origin: Origin
    let episode: [EpisodeData]
}

struct Origin: Decodable {
    let name: String
}

struct EpisodeData: Decodable {
    let id: Int
    let name: String
    let episode: String
    let airDate: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case episode = "episode"
        case airDate = "air_date"
    }
}
