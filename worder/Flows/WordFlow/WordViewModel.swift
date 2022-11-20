//
//  WordViewModel.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import RxSwift
import RxDataSources

final class WordViewModel: ViewModel {
    
    let word: WordModel
    let disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<AnimatedSectionModel>(configureCell: { (_, _, _, _) in fatalError() })
    let data = BehaviorSubject<[AnimatedSectionModel]>(value: [.init(title: "Section: 0", data: ["Some data"])])
    init(_ word: WordModel) {
        self.word = word
    }
}
