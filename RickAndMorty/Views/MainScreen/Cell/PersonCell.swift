//
//  PersonCell.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import UIKit

final class PersonCell: UICollectionViewCell {
    static let reuseID = "PersonCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Verdana-Bold", size: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        
        contentView.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            photoImageView.widthAnchor.constraint(equalToConstant: self.frame.width - 16),
            photoImageView.heightAnchor.constraint(equalToConstant: self.frame.width - 16),
            photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 16),
            nameLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configureCell(with: ResultCharacter) {
        photoImageView.image = with.image
        nameLabel.text = with.name
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = ""
    }

}
