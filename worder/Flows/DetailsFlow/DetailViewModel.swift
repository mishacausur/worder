//
//  DetailViewModel.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import RxSwift

final class DetailViewModel: ViewModel {
    // INITIAL ARRAY
    private let words: [WordModel]
    
    // RX ARRAY FOR TABLEVIEW
    var items: Observable<[WordModel]> {
        return Observable.just(words)
    }
    
    let disposeBag = DisposeBag()
    
    init(_ words: [WordModel]) {
        self.words = words
    }
    
    func wordFlow(_ word: WordModel) {
        coordinator?.route(.word(word))
    }
}

