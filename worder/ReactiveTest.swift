//
//  ReactiveTest.swift
//  worder
//
//  Created by Misha Causur on 17.11.2022.
//

import RxSwift

struct ReactiveTestImpl {
    
    func react() {
        reactiveExampleSideEffect()
    }
    
    // MARK: - FOUNDATION
    
    private func reactiveExampleJust() {
        example("just") {
            let observable = Observable.just("Hi there, u'r using RxSwift now, congrats")
            
            observable.subscribe { print($0) }
        }
    }
    
    private func reactiveExampleOf() {
        example("of") {
            let observable = Observable.of(1, 2, 3, 4, 5)
            observable.subscribe { print($0) }
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
            
            sequence.subscribe { print($0) }
        }
    }
    
    private func reactiveExampleMap() {
        example("map") {
            let sequence = Observable.of(1, 2, 4, 6).map { "the number is \($0 * 10)" }
            sequence.subscribe { print($0) }
        }
    }
    
    private func reactiveExampleMerge() {
        example("merge") {
            let firstThread = Observable.of("i", "t", "w")
            let secondThread = Observable.of("m", "u", "o")
            
            let combine = Observable.of(firstThread, secondThread)
            
            let merger = combine.merge()
            merger.subscribe { print($0) }
        }
    }
    
    // MARK: - SUBJECTS
    
    private func reactiveExamplePublished() {
        example("published") {
            let disposableBag = DisposeBag()
            let subject = PublishSubject<String>()
            subject.subscribe { print("Subscription 1 ", $0) }.disposed(by: disposableBag)
            subject.on(Event<String>.next("Hi there"))
            subject.on(.next("it's working using RxSwift now"))
            subject.onNext("It's amazing, isn't it?")
            
            subject.subscribe(onNext: { print("Subscription 2 ", $0) }).disposed(by: disposableBag)
            
            subject.onNext("it's made right after the second one has been implemented")
            subject.onNext("and it's kind of multi calling")
        }
    }
    
    private func reactiveExampleBehavior() {
        example("behavior") {
            let disposableBag = DisposeBag()
            let subject = BehaviorSubject(value: 1)
            
            let firstSubscriber = subject.subscribe(onNext: { print(#line, $0) }).disposed(by: disposableBag)
            subject.onNext(2)
            subject.onNext(3)
            
            let secondSubscriber = subject.subscribe(onNext: { print(#line, $0)}).disposed(by: disposableBag)
        }
    }
    
    private func reactiveExampleReplay() {
        example("replay") {
            let disposableBag = DisposeBag()
            let subject = ReplaySubject<Int>.create(bufferSize: 5)
            
            subject.subscribe { print("First subscription: ", $0) }.disposed(by: disposableBag)
            
            subject.onNext(1)
            subject.onNext(2)
            subject.onNext(3)
            
            subject.subscribe { print("Second subscription: ", $0) }.disposed(by: disposableBag)
            
            subject.onNext(4)
            subject.onNext(5)
        }
    }
    
    private func reactiveExampleSideEffect() {
        example("side effects") {
            let disposableBag = DisposeBag()
            let sequence  = [0, 32, 100, 300]
            let temporary = Observable.from(sequence)
            temporary
                .do(onNext: { print("\($0)F = ", terminator: "")})
                .map { Double($0 - 31) * 5/9.0 }
                .subscribe(onNext: { print(String(format: "%.1f", $0))})
                .disposed(by: disposableBag)
        }
    }
}
