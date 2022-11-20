//
//  MainViewModel.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import RxSwift

final class MainViewModel: ViewModel {
    private let reactive = ReactiveTestImpl()
    private(set) var words: [WordModel]?
    func getData() {
        reactive.react()
        let manager = NetworkService()
        Task {
            await manager.getWords {
                switch $0 {
                case .success(let words):
                    self.words = words
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func moveToDetails() {
        guard let words = words else {
            return
        }
        coordinator?.route(.details(words))
    }
}
