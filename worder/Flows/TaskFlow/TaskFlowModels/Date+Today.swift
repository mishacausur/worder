//
//  Date+Today.swift
//  worder
//
//  Created by Misha Causur on 05.01.2023.
//

import Foundation

extension Date {
    var dateAndTimeText: String {
        let timeText = formatted(date: .omitted, time: .shortened)
        switch Locale.current.calendar.isDateInToday(self) {
        case true:
            let timeFormat = NSLocalizedString("Today at %@", comment: "today string")
            return String(format: timeFormat, timeText)
        case false:
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at $@", comment: "date and time")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    
    var dayText: String {
        switch Locale.current.calendar.isDateInToday(self) {
        case true:
            return NSLocalizedString("Today", comment: "Just today")
        case false:
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
