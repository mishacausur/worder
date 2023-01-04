//
//  TodayViewAssembly.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

extension ModuleFactory {
    
    static func createTodayModule(_ coordinator: Coordinatable) -> Module<TodayViewController> {
        
        let viewModel = TodayViewModel()
        viewModel.coordinator = coordinator
        let viewController = TodayViewController(viewModel: viewModel)
        return Module(presentable: viewController)
    }
}
