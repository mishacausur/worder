//
//  WordViewController.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit
import RxSwift

final class WordViewController: ViewController<WordView, WordViewModel> {
    
//    var collectionView: UICollectionView {
//        mainView.collectionView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.word.word
        configure()
        
        viewModel.data
            .drive(mainView.tableView.rx.items(cellIdentifier: "Cell")) { _, repos, cell in
            cell.textLabel?.text = repos.name
            cell.detailTextLabel?.text = repos.url
        }
            .disposed(by: viewModel.disposeBag)
        
        mainView.searchBar
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)
        
        mainView.searchBar
            .rx
            .cancelButtonClicked
            .map { "" }
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)
        
        viewModel.data
            .asDriver()
            .map { "\($0.count) repos" }
            .drive(navigationItem.rx.title)
            .disposed(by: viewModel.disposeBag)
    }
    
    private func configure() {
        definesPresentationContext = true
    }
    /*
    private func configure() {
        viewModel.dataSource.configureCell = { (_, collectionView, indexPath, title) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.identifier, for: indexPath) as! WordCollectionViewCell
            cell.configure(title)
            return cell
        }
        
        viewModel.data
            .asDriver(onErrorJustReturn: [.init(title: "Section: 0", data: ["Some data"])])
            .drive(collectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: viewModel.disposeBag)
    }
     */
}



