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
    
    internal var store: ReminderStore { ReminderStore.shared }
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        
        let item = getItem(with: id)
        var defaultConfiguration = cell.defaultContentConfiguration()
        defaultConfiguration.text = item.title
        defaultConfiguration.secondaryText = item.dueDate.dateAndTimeText
        defaultConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = defaultConfiguration
        var doneConf = doneItemConfiguration(for: item)
        doneConf.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [ doneButtonAccessibilityAction(for: item) ]
        cell.accessibilityValue = item.isComplete ? reminderCompletedValue : reminderNotCompletedValue
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
    
    internal func reminderStoreChanged() {
        Task {
            reminders = try await store.read()
            updateSnapshot()
        }
    }
    
    internal func getReminders() {
        prepareStore()
    }
    
    internal func getItem(with id: Reminder.ID) -> Reminder {
        reminders[reminders.reminderIndex(with: id)]
    }
    
    internal func updateItem(_ item: Reminder, with id: Reminder.ID) {
        reminders[reminders.reminderIndex(with: id)] = item
    }
    
    internal func completeItem(with id: Reminder.ID) {
        var item = getItem(with: id)
        item.isComplete.toggle()
        updateItem(item, with: id)
        updateSnapshot(for: [id])
    }
    
    func updateSnapshot(for itemsThatChanged: [Reminder.ID] = []) {
        let items = itemsThatChanged.filter { id in filteredReminders.contains { $0.id == id }}
        var snapshot = SnapShot()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredReminders.map { $0.id })
        if !items.isEmpty {
            snapshot.reloadItems(items)
        }
        header?.updateProgress(progress)
        dataSource.apply(snapshot)
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle completion", comment: "Reminder done button accessibility label")
        let action = UIAccessibilityCustomAction(name: name) { [weak self] _ in
            self?.completeItem(with: reminder.id)
            return true
        }
        return action
    }
    
    internal func deleteReminder(_ item: Reminder.ID) {
        let index = reminders.reminderIndex(with: item)
        reminders.remove(at: index)
    }
    
    private func prepareStore() {
        Task {
            do {
                try await store.grantAccess()
                reminders = try await store.read()
                NotificationCenter.default.addObserver(self, selector: #selector(eventStoreChanged), name: .EKEventStoreChanged, object: nil)
            } catch EventError.accessDenied, EventError.accessRestricted {
                #if DEBUG
                reminders = Reminder.sampleData
                #endif
            } catch {
                showError(error)
            }
            updateSnapshot()
        }
    }
}
