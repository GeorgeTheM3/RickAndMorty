//
//  Extension + UIImage.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 18.08.2023.
//

import UIKit

extension UIImage {
    
    static let planet: UIImage = {
        guard let image = UIImage(named: "planet") else { return UIImage()}
        return image
    }()
}


