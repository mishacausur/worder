//
//  TodayViewController+DataSource.swift
//  worder
//
//  Created by Misha Causur on 07.01.2023.
//

import UIKit.UICollectionView
import UIKit.UIDiffableDataSource

extension TodayView {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        
        let item = getItem(with: id)
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
        let button = TodayCheckButton()
        button.id = reminder.id
        button.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.setImage(.init(named: "gear"), for: .selected)
        return .init(customView: button, placement: .leading(displayed: .always))
    }
    
    private func getItem(with id: Reminder.ID) -> Reminder {
        reminders[reminders.reminderIndex(with: id)]
    }
    
    private func updateItem(_ item: Reminder, with id: Reminder.ID) {
        reminders[reminders.reminderIndex(with: id)] = item
    }
    
    internal func completeItem(with id: Reminder.ID) {
        var item = getItem(with: id)
        item.isComplete.toggle()
        updateItem(item, with: id)
    }
}
