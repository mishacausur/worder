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
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configure() {
        collectionView.collectionViewLayout = listLayout()
        register()
        backgroundColor = .white
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
    
    private func register() {
        let cellReg = createCellConfiguration()
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: {
            return $0.dequeueConfiguredReusableCell(using: cellReg, for: $1, item: $2)
        })
        
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    private func createCellConfiguration() -> UICollectionView.CellRegistration<UICollectionViewListCell, String> {
        .init { (cell: UICollectionViewListCell,
                 indexPath: IndexPath,
                 itemIdentifier: String) in
            let item = Reminder.sampleData[indexPath.item]
            var defaultConfiguration = cell.defaultContentConfiguration()
            defaultConfiguration.text = item.title
            cell.contentConfiguration = defaultConfiguration
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.cornerRadius = 8
            cell.backgroundConfiguration = backgroundConfig
        }
    }
}
