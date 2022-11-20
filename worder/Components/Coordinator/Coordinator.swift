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
    
    func route(_ destination: Route) {
        switch destination {
        case .addWord:
            print("started")
        case .dismiss:
            navigationController.popViewController(animated: true)
        case .details(let words):
            startDetailFlow(words)
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
}

