//
//  TodayViewController+DataSource.swift
//  worder
//
//  Created by Misha Causur on 07.01.2023.
//

import UIKit.UICollectionView
import UIKit.UIDiffableDataSource

extension TodayView {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        
        let item = Reminder.sampleData[indexPath.item]
        var defaultConfiguration = cell.defaultContentConfiguration()
        defaultConfiguration.text = item.title
        defaultConfiguration.secondaryText = item.dueDate.dateAndTimeText
        defaultConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = defaultConfiguration
        var doneConf = doneItemConfiguration(for: item)
        doneConf.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [.customView(configuration: doneConf), .disclosureIndicator(displayed: .always)]
        var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfig.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfig
    }
    
    private func doneItemConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let iconName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: iconName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return .init(customView: button, placement: .leading(displayed: .always))
        
        
    }
}
