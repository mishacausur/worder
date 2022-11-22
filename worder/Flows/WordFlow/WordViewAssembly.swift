//
//  WordViewAssembly.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

extension ModuleFactory {
    
    static func createWordModule(_ coordinator: Coordinatable, word: WordModel) -> Module<WordViewController> {
        
        let viewModel = WordViewModel(word, provider: .init())
        viewModel.coordinator = coordinator
        let viewController = WordViewController(viewModel: viewModel)
        return Module(presentable: viewController)
    }
}
