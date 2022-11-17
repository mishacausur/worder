//
//  MainViewModel.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import RxSwift

final class MainViewModel: ViewModel {
    func getData() {
        reactiveExampleFilter()
        let manager = NetworkService()
        Task {
            await manager.getWords {
                print($0)
            }
        }
    }
    
    private func reactiveExampleJust() {
        example("just") {
            let observable = Observable.just("Hi there, u'r using RxSwift now, congrats")
            
            observable.subscribe {
                print($0)
            }
        }
    }
    
    private func reactiveExampleOf() {
        example("of") {
            let observable = Observable.of(1, 2, 3, 4, 5)
            observable.subscribe {
                print($0)
            }
        }
    }
    
    private func reactiveExampleCreate() {
        example("create") {
            let items = [1, 2, 3, 4, 5]
            Observable.from(items).subscribe {
                print($0)
            } onError: {
                print($0)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
        }
    }
    
    private func reactiveExampleFilter() {
        example("filter") {
            let sequence = Observable.of(1, 2, 4, 6, 10, 14, 27).filter { $0 >= 10 }
            
            sequence.subscribe {
                print($0)
            }
        }
    }
}
