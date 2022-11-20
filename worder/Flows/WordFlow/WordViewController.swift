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

final class WordCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        "cell"
    }
    
    private let label = UILabel().configure { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        addViews(label)
        [label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
         label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
         label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)].forEach { $0.isActive = true }
    }
    
    func configure(_ title: String) {
        label.text = title
    }
}
