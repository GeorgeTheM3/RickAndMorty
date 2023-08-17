//
//  NetwrokServiceProtocol.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import Foundation

protocol NetwrokServiceProtocol {
    func downloadData() -> [Character]
    func downloadDataFor(_ url: String) -> [Character]
}
