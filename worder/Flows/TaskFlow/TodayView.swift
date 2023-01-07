//
//  TodayView.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

import UIKit.UICollectionView
import UIKit.UIDiffableDataSource
import class UIKit.UIView

final class TodayView: Viеw {

    var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configure() {
        collectionView.collectionViewLayout = listLayout()
        
        backgroundColor = .white
        
        let cellReg = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        register(cellReg)
        super.configure()
    }
    
    override func addViews() {
        addSubview(collectionView)
    }
    
    override func layout() {
        [collectionView.topAnchor.constraint(equalTo: topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
         collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)].forEach { $0.isActive = true }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConf = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConf.showsSeparators = false
        listConf.backgroundColor = .clear
        return .list(using: listConf)
    }
    
    private func register(_ using: UICollectionView.CellRegistration<UICollectionViewListCell, String>) {
       
        dataSource = DataSource(collectionView: collectionView, cellProvider: {
            return $0.dequeueConfiguredReusableCell(using: using, for: $1, item: $2)
        })
        
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
}
