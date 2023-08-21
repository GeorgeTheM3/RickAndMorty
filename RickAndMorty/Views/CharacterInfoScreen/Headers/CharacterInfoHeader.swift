//
//  CharacterInfoHeader.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 18.08.2023.
//

import UIKit

final class CharacterInfoHeader: UITableViewHeaderFooterView {
    static let reuseId: String = "CharacterInfoHeader"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .myBoldFont
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.font = .myRegularFont
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let screenSize = UIScreen.main.bounds.size
        
        contentView.appendSubviewsToView(views: [photoImageView, nameLabel, statusLabel])
        
        contentView.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            photoImageView.heightAnchor.constraint(equalToConstant: screenSize.width - 227 ),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 113),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -114),
            
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 24),
            
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
        ])
    }

    func configureHeader(with: ResultCharacter) {
        photoImageView.image = with.image
        nameLabel.text = with.name
        statusLabel.text = with.status
    }
}
