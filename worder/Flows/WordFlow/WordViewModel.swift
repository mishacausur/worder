//
//  WordViewModel.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import RxCocoa
import RxDataSources
import RxSwift

final class WordViewModel: ViewModel {
    
    let word: WordModel
    let disposeBag = DisposeBag()
    /*
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>(configureCell: { (_, _, _, _) in fatalError() })
    let data = BehaviorSubject<[AnimatedSectionModel]>(value: [.init(title: "Section: 0", data: ["Some data"])])
    */
    
    let searchText = BehaviorRelay<String>(value: "")
    
    let provider: APIProvider
    let data: Driver<[Repository]>
    
    init(_ word: WordModel, provider: APIProvider) {
        self.word = word
        self.provider = provider
        data = self.searchText.asObservable()
            .throttle(.milliseconds(3), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                provider.getRepos($0)
            }
            .asDriver(onErrorJustReturn: [])
    }
}
