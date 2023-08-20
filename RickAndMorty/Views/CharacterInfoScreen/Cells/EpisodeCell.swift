//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 18.08.2023.
//

import UIKit

class EpisodeCell: UITableViewCell {
    static let reuseID = "EpisodeCell"
    
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
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGreen
        label.font = .mySmallFont
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemGray
        label.font = .mySmallFont
        return label
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
        background.appendSubviewsToView(views: [titleLabel, seasonLabel, dateLabel])
        
        background.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            titleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            
            seasonLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -14),
            seasonLabel.widthAnchor.constraint(equalToConstant: 160),
            seasonLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: seasonLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16)
        ])
    }
    
    func configureCell(with: EpisodeData) {
        titleLabel.text = with.name
        seasonLabel.text = String.formatSeason(with.episode)
        dateLabel.text = with.airDate
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        seasonLabel.text = ""
        dateLabel.text = ""
    }

}
