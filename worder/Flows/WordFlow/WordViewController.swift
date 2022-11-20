//
//  WordViewController.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit
import RxSwift

final class WordViewController: ViewController<WordView, WordViewModel> {
    
    var collectionView: UICollectionView {
        mainView.collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.word.word
        configure()
    }
    
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
}
