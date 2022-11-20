//
//  WordView.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit

final class WordView: Viеw {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let collectionLayout = UICollectionViewLayout()
    
    override func configure() {
        backgroundColor = .orange
        collectionView.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.identifier)
        collectionView.collectionViewLayout = collectionLayout
        super.configure()
    }
    
    override func addViews() {
        addViews(collectionView)
    }
    
    override func layout() {
        [collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
         collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
         widthAnchor.constraint(equalToConstant: 100),
         heightAnchor.constraint(equalToConstant: 100)].forEach { $0.isActive = true }
    }
}
