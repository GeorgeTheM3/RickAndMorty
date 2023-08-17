//
//  NetwrokService.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

class NetwrokService: NetwrokServiceProtocol {
    private let networkManager =  NetworkManager()

    func downloadData() -> [Character] {
        return []
    }
    
    func downloadDataFor(_ url: String) -> [Character] {
        return []
    }
}
