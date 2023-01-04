//
//  TodayView.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

import class UIKit.UIView
import class UIKit.UICollectionView
import class UIKit.UICollectionViewFlowLayout

final class TodayView: Viеw {
    private let collectionLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    
    override func configure() {
        // register
        collectionView.backgroundColor = .darkGray
        super.configure()
    }
    
    override func addViews() {
        addSubview(collectionView)
    }
    
    override func layout() {
        collectionView.frame = self.frame
    }
}
