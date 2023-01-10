//
//  TodayViewController.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

import class UIKit.UIViewController

final class TodayViewController: ViewController<TodayView, TodayViewModel> {
    override func viewDidLoad() {
        mainView.modelDidSelect = { [weak viewModel] in
            viewModel?.coordinateDetails(with: $0, onChange: $1)
        }
        title = "Today Me"
    }
}
