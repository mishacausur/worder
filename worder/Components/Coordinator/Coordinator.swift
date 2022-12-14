//
//  Coordinator.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.UINavigationController

final class Coordinator: Coordinatable {
    
    unowned let window: UIWindow
    var navigationController: UINavigationController
   
    init(_ window: UIWindow) {
        self.window = window
        navigationController = .init()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        startMainFlow()
    }
    
    func startToday() {
        startTodayFlow()
    }
    
    func route(_ destination: Route) {
        switch destination {
        case .addWord:
            print("started")
        case .dismiss:
            navigationController.popViewController(animated: true)
        case .details(let words):
            startDetailFlow(words)
        case .word(let word):
            startWordFlow(word)
        case let .todayDetail(item, handler):
            startTodayDetailsFlow(item, onChange: handler)
        }
    }
    
    private func startMainFlow() {
        let mainModule = ModuleFactory.createMainModule(self)
        navigationController.pushViewController(mainModule.presentable, animated: false)
    }
    
    private func startDetailFlow(_ words: [WordModel]) {
        let detailModule = ModuleFactory.createDetailModule(self, words: words)
        navigationController.pushViewController(detailModule.presentable, animated: true)
    }
    
    private func startWordFlow(_ word: WordModel) {
        let wordModule = ModuleFactory.createWordModule(self, word: word)
        navigationController.pushViewController(wordModule.presentable, animated: true)
    }
    
    private func startTodayFlow() {
        let todayModule = ModuleFactory.createTodayModule(self)
        navigationController.pushViewController(todayModule.presentable, animated: true)
    }
    
    private func startTodayDetailsFlow(_ item: Reminder, onChange: @escaping (Reminder) -> Void) {
        let vc = TodayItemViewController(reminder: item, onChange: onChange)
        navigationController.pushViewController(vc, animated: true)
    }
}

