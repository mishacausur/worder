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
    var modelDidSelect: ((Reminder, @escaping (Reminder) -> Void) -> Void)?
    var dataSource: DataSource!
    var reminders = Reminder.sampleData
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configure() {
        collectionView.collectionViewLayout = listLayout()
        collectionView.delegate = self
        backgroundColor = .todayNavigationBackground
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
        listConf.trailingSwipeActionsConfigurationProvider = makeSwipeAction
        return .list(using: listConf)
    }
    
    private func register(_ using: UICollectionView.CellRegistration<UICollectionViewListCell, String>) {
       
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView,
                                                                                 indexPath: IndexPath,
                                                                                 itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: using, for: indexPath, item: itemIdentifier)
        })
        updateSnapshot()
        collectionView.dataSource = dataSource
    }
    
    private func showDetail(for id: Reminder.ID) {
        let item = getItem(with: id)
        let updateHandler: (Reminder) -> Void = { [weak self] in
            self?.updateItem($0, with: $0.id)
            self?.updateSnapshot(for: [$0.id])
        }
        modelDidSelect?(item, updateHandler)
    }
    
    func addReminder(_ item: Reminder) {
        reminders.append(item)
        updateSnapshot()
    }
    
    private func makeSwipeAction(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        let deleteTitle = NSLocalizedString("Delete", comment: "delete action")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteTitle) { [weak self] _, _, completion in
            self?.deleteReminder(id)
            self?.updateSnapshot()
            completion(false)
        }
        
        return .init(actions: [deleteAction])
    }
}

extension TodayView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.row].id
        showDetail(for: id)
        return false
    }
}
