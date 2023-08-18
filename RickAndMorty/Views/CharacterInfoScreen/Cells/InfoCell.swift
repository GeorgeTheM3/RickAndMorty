//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 17.08.2023.
//

import UIKit

class InfoCell: UITableViewCell {
    static let reuseID = "InfoCell"
    
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = .myBackgroundCell
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Species"
        return label
    }()
    
    private lazy var speciesValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .myBoldFont
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Type"
        return label
    }()
    
    private lazy var typeValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .myBoldFont
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Gender"
        return label
    }()
    
    private lazy var genderValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .myBoldFont
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
        background.appendSubviewsToView(views: [speciesLabel, speciesValueLabel, typeLabel, typeValueLabel, genderLabel, genderValueLabel])
        
        background.subviews.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            speciesLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 16),
            speciesLabel.widthAnchor.constraint(equalToConstant: 70),
            
            speciesValueLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor),
            speciesValueLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -16),
            speciesValueLabel.leadingAnchor.constraint(equalTo: speciesLabel.trailingAnchor),
            
            typeLabel.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            typeLabel.widthAnchor.constraint(equalToConstant: 70),
            
            typeValueLabel.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            typeValueLabel.trailingAnchor.constraint(equalTo: speciesValueLabel.trailingAnchor),
            typeValueLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            
            genderLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -16),
            genderLabel.leadingAnchor.constraint(equalTo: speciesLabel.leadingAnchor),
            genderLabel.widthAnchor.constraint(equalToConstant: 70),
            
            genderValueLabel.bottomAnchor.constraint(equalTo: genderLabel.bottomAnchor),
            genderValueLabel.trailingAnchor.constraint(equalTo: speciesValueLabel.trailingAnchor),
            genderValueLabel.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor),
        ])
    }
    
    func configureCell(with: ResultCharacter) {
        speciesValueLabel.text = with.species
        typeValueLabel.text = with.type
        genderValueLabel.text = with.gender
    }
    
    override func prepareForReuse() {
        speciesValueLabel.text = ""
        typeValueLabel.text = ""
        genderValueLabel.text = ""
    }

}
