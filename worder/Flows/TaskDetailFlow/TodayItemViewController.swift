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
        listConf.headerMode = .firstItemInSection
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
        snapShot.appendItems([.header(.empty), .title, .date, .note, .time], toSection: .view)
        dataSource.apply(snapShot)
    }
    
    private func updateSnapShotEditing() {
        var snapshot = SnapShot()
        snapshot.appendSections([.title, .date, .note])
        snapshot.appendItems([.header(Section.title.name), .editText(reminder.title)], toSection: .title)
        snapshot.appendItems([.header(Section.date.name), .editDate(reminder.dueDate)], toSection: .date)
        snapshot.appendItems([.header(Section.note.name), .editText(reminder.notes)], toSection: .note)
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
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.title, .editText(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case(.date, .editDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.note, .editText(let notes)):
            cell.contentConfiguration = textConfiguration(for: cell, with: notes)
        default:
            fatalError("unexpected section and row")
        }
        cell.tintColor = .todayPrimaryTint
    }
}
