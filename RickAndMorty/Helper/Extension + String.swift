//
//  Extension + String.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 20.08.2023.
//

import UIKit

extension String {
    static func formatSeason(_ string: String) -> String {
        var season = String(string.prefix(3))
        var episode = String(string.suffix(3))
        season.removeFirst()
        episode.removeFirst()
        
        if season.first == "0" {
            season.removeFirst()
        }
        if episode.first == "0" {
            episode.removeFirst()
        }
        
        return "Episode: \(episode), Season: \(season) "
    }
}


