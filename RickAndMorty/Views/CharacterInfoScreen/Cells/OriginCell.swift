//
//  OriginCell.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 18.08.2023.
//

import UIKit

class OriginCell: UITableViewCell {
    static let reuseID = "OriginCell"
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .myBackgroundCell
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .myBoldFont
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGreen
        label.font = .mySmallFont
        return label
    }()
    
    private lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .myGray
        imageView.image = .planet
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(background)
        background.appendSubviewsToView(views: [titleLabel, planetLabel, planetImageView])
        
        background.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            planetImageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            planetImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
            planetImageView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
            planetImageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.2),
            
            titleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            planetLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -16),
            planetLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            planetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)            
        ])
    }
    
    func configureCell(with: ResultCharacter) {
        titleLabel.text = "Pilot"
        planetLabel.text = "Episode 1, Season 2"
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        planetLabel.text = ""
    }

}
