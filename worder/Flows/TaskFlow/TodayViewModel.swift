//
//  TodayViewModel.swift
//  worder
//
//  Created by Misha Causur on 04.01.2023.
//

import Foundation

final class TodayViewModel: ViewModel {
    
    enum ReminderState: Int, CaseIterable {
        case today
        case future
        case all
        
        var name: String {
            switch self {
            case .today:
                return NSLocalizedString("Today", comment: "only today's reminders")
            case .future:
                return NSLocalizedString("Future", comment: "only future's reminders")
            case .all:
                return NSLocalizedString("All", comment: "all reminders")
            }
        }
        
        func shouldInclude(_ date: Date) -> Bool {
            let isToday = Locale.current.calendar.isDateInToday(date)
            
            switch self {
            case .today:
                return isToday
            case .future:
                return (date > Date.now) && !isToday
            case .all:
                return true
            }
        }
    }
    
    func coordinateDetails(with item: Reminder, onChange: @escaping (Reminder) -> Void) {
        coordinator?.route(.todayDetail(item, onChange: onChange))
    }
}
