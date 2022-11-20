//
//  WordCollectionViewCell.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit

final class WordCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        "collectionCell"
    }
    
    private let label = UILabel().configure { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addViews(label)
        [label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
         label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
         label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)].forEach { $0.isActive = true }
    }
    
    func configure(_ title: String) {
        label.text = title
    }
}

