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
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
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
        let cellReg = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = .init(collectionView: collectionView, cellProvider: {
            return $0.dequeueConfiguredReusableCell(using: cellReg, for: $1, item: $2)
        })
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var conf = cell.defaultContentConfiguration()
        conf.text = getText(for: row)
        conf.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        conf.image = row.image
        cell.contentConfiguration = conf
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
