//
//  TodayItemViewController.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import UIKit.UICollectionLayoutList
import UIKit.UIDiffableDataSource
import class UIKit.UICollectionViewController

final class TodayItemViewController: UICollectionViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, Row>
    private var dataSource: DataSource!
    var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConf = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConf.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConf)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize TodayItemViewController using init(reminder:)")
    }
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = editButtonItem
        let cellReg = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = .init(collectionView: collectionView, cellProvider: {
            return $0.dequeueConfiguredReusableCell(using: cellReg, for: $1, item: $2)
        })
        updateSnapshotViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        switch editing {
        case true:
            updateSnapShotEditing()
        case false:
            updateSnapshotViewing()
        }
    }
    
    private func updateSnapshotViewing() {
        var snapShot = SnapShot()
        snapShot.appendSections([.view])
        snapShot.appendItems([.title, .date, .note, .time], toSection: .view)
        dataSource.apply(snapShot)
    }
    
    private func updateSnapShotEditing() {
        var snapshot = SnapShot()
        snapshot.appendSections([.title, .date, .note])
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath:  IndexPath) -> Section {
        let sectionIndex = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionIndex) else {
            fatalError("unable find the section by its index")
        }
        return section
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (.view, _):
            var conf = cell.defaultContentConfiguration()
            conf.text = getText(for: row)
            conf.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
            conf.image = row.image
            cell.contentConfiguration = conf
        default:
            fatalError("unexpected section and row")
        }
        cell.tintColor = .todayPrimaryTint
    }
    
    func getText(for row: Row) -> String? {
        switch row {
        case .date:
            return reminder.dueDate.dayText
        case .note:
            return reminder.notes
        case .time:
            return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title:
            return reminder.title
        }
    }
}
