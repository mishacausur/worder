//
//  MainViewAssembly.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

extension ModuleFactory {
    
    static func createMainModule(_ coordinator: Coordinatable) -> Module<MainViewController> {
        
        let viewModel = MainViewModel()
        viewModel.coordinator = coordinator
        let viewController = MainViewController(viewModel: viewModel)
        return Module(presentable: viewController)
    }
}

