//
//  TodayViewModel.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

final class TodayViewModel: ViewModel {
    func coordinateDetails(with item: Reminder, onChange: @escaping (Reminder) -> Void) {
        coordinator?.route(.todayDetail(item, onChange: onChange))
    }
}
