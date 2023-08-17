//
//  NetwrokService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class NetwrokService: NetwrokServiceProtocol {
    @Published var characters: [Character] = []
    
    private let networkManager =  NetworkManager()
    
    func fetchCharacterData(page: Int = 1) {
        networkManager.fetchCharacterData(page: page)
    }
}
