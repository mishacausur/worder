//
//  MainViewController.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

final class MainViewController: ViewController<MainView, MainViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        mainView.buttonDidTapped = { [weak self] in
            self?.viewModel.moveToDetails()
        }
    }
}
