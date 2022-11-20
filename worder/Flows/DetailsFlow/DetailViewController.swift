//
//  DetailViewController.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import RxSwift
import UIKit
final class DetailViewController: ViewController<DetailView, DetailViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
    }
    
    func configureDataSource() {
        viewModel.items
            .bind(to: mainView.tableView.rx.items(cellIdentifier: DetailTableViewCell.identifier)) {( _, word, cell: DetailTableViewCell) in
                cell.configureLabels(word)
            }
            .disposed(by: viewModel.disposeBag)
    }
}
