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
    
    private typealias State = TodayViewModel.ReminderState
    var title: String = .empty {
        didSet {
           titleDidChange(title)
        }
    }
    var progress: CGFloat {
        let size = 1.0 / CGFloat(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
            let completed = $1.isComplete ? size : 0
            return $0 + completed
        }
        return progress
    }
    var titleDidChange: (String) -> Void = { _ in }
    var modelDidSelect: ((Reminder, @escaping (Reminder) -> Void) -> Void)?
    var dataSource: DataSource!
    var reminders = Reminder.sampleData
    var filteredReminders: [Reminder] {
        reminders
            .filter { state.shouldInclude($0.dueDate) }
            .sorted { $0.dueDate < $1.dueDate }
    }
    private var state: State = .today
    let segmenter = UISegmentedControl(items: State.allCases.map(\.name))
    internal var header: ProgressiveHeaderView?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configure() {
        collectionView.collectionViewLayout = listLayout()
        collectionView.delegate = self
        backgroundColor = .todayNavigationBackground
        segmenter.selectedSegmentIndex = state.rawValue
        segmenter.addTarget(self, action: #selector(didChangeSegment(_:)), for: .valueChanged)
        collectionView.backgroundColor = .todayGradientFutureBegin
        let cellReg = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        register(cellReg)
        let headerReg = UICollectionView.SupplementaryRegistration(
            elementKind: ProgressiveHeaderView.elementaryKind,
            handler: supplementaryRegistrationHandler
        )
        dataSource.supplementaryViewProvider = {
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerReg, for: $2)
        }
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
        listConf.headerMode = .supplementary
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
    
    private func supplementaryRegistrationHandler(_ headerView: ProgressiveHeaderView, kind: String, indexPath: IndexPath) {
        header = headerView
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
    
    @objc private func didChangeSegment(_ sender: UISegmentedControl) {
        state = State(rawValue: sender.selectedSegmentIndex) ?? .today
        updateSnapshot()
    }
}

extension TodayView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filteredReminders[indexPath.row].id
        showDetail(for: id)
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == ProgressiveHeaderView.elementaryKind,
              let progressView = view as? ProgressiveHeaderView else {
            return
        }
        progressView.updateProgress(progress)
    }
}
