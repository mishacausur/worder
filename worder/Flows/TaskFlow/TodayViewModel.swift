//
//  TodayViewModel.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

final class TodayViewModel: ViewModel {
    func corrdinateDetails(wirh item: Reminder) {
        coordinator?.route(.todayDetail(item))
    }
}
