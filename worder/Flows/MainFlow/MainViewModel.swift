//
//  MainViewModel.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import RxSwift

final class MainViewModel: ViewModel {
    private let reactive = ReactiveTestImpl()
    func getData() {
        reactive.react()
        let manager = NetworkService()
        Task {
            await manager.getWords {
                print($0)
            }
        }
    }
}
