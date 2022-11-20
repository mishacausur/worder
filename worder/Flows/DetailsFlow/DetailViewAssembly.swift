//
//  DetailViewAssembly.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

extension ModuleFactory {
    
    static func createDetailModule(_ coordinator: Coordinatable, words: [WordModel]) -> Module<DetailViewController> {
        
        let viewModel = DetailViewModel(words)
        viewModel.coordinator = coordinator
        let viewController = DetailViewController(viewModel: viewModel)
        return Module(presentable: viewController)
    }
}
