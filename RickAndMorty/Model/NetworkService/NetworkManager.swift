//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation
import Combine
import UIKit

enum TypeURL {
    case character
    case episode
}

final class NetworkManager {
    @Published var characters: [ResultCharacter] = []
    
    var cancellable = Set<AnyCancellable>()
    
    func fetchCharacterData(page: Int) {
        let url = "https://rickandmortyapi.com/api/character?page=" + "\(page)"
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: Character.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Completed")
                    break
                case .failure(let error):
                    print("Receiver error \(error)")
                    break
                }
            }, receiveValue: { char in
                char.results.forEach({ character in
                    self.downloadImage(for: character)
                })
            })
            .store(in: &cancellable)
    }
    
    func downloadImage(for character: Result) {
        let url = character.image
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    print("Completed download image \(character.id)")
                    break
                case .failure(let error):
                    print("Receiver error \(error)")
                    break
                }
            }, receiveValue: { data in
                guard let image = UIImage(data: data) else { return }
                let type = character.type == "" ? "None" : character.type
                let person = ResultCharacter(id: character.id, image: image, imageURL: character.image, status: character.status, name: character.name, species: character.species, gender: character.gender, type: type, origin: character.origin, episode: character.episode)
                self.characters.append(person)
            })
            .store(in: &cancellable)
    }
}
