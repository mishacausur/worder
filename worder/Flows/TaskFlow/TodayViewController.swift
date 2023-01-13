//
//  TodayViewController.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

import Foundation.NSString
import class UIKit.UIViewController
import class UIKit.UINavigationController
import class UIKit.UIBarButtonItem

final class TodayViewController: ViewController<TodayView, TodayViewModel> {
    override func viewDidLoad() {
        configureNavBar()
        configureHandlers()
    }
    
    private func configureHandlers() {
        mainView.modelDidSelect = { [weak viewModel] in
            viewModel?.coordinateDetails(with: $0, onChange: $1)
        }
        mainView.present = { [weak self] in
            self?.present($0, animated: true)
        }
        mainView.dismiss = { [weak self] in
            self?.dismiss(animated: true)
        }
        mainView.titleDidChange = { [weak self] in
            self?.title = $0
        }
    }
    
    private func configureNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString("Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        navigationItem.titleView = mainView.segmenter
    }
    
    @objc private func didPressAddButton(_ sender: UIBarButtonItem) {
        let reminder: Reminder = .init(title: .empty, dueDate: Date.now)
        let handler: (Reminder) -> Void = { [weak self] in
            self?.mainView.addReminder($0)
            self?.dismiss(animated: true)
        }
        let viewController = TodayItemViewController(reminder: reminder, onChange: handler)
        viewController.isAddingMode = true
        viewController.setEditing(true, animated: false)
        viewController.navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelAdd(_:)))
        viewController.navigationItem.title = NSLocalizedString("Add Reminder", comment: "Add Reminder view controller title")
        let nc = UINavigationController(rootViewController: viewController)
        present(nc, animated: true)
    }
    
    @objc private func didCancelAdd(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
