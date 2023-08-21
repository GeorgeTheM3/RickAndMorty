//
//  SimpleHeader.swift
//  RickAndMorty
//
//  Created by Георгий Матченко on 18.08.2023.
//

import UIKit

final class SimpleHeader: UITableViewHeaderFooterView {
    static let reuseId: String = "SimpleHeader"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 0, width: 300, height: 35)
        label.textAlignment = .left
        label.font = .myBoldFont
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
        contentView.addSubview(titleLabel)
    }

    func configureHeader(with title: String) {
        titleLabel.text = title
    }
}
