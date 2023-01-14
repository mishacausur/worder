//
//  Reminder+Event.swift
//  worder
//
//  Created by Misha Causur on 15.01.2023.
//

import class EventKit.EKReminder

extension Reminder {
    init(with event: EKReminder) throws {
        guard let date = event.alarms?.first?.absoluteDate else {
            throw EventError.wrongDate
        }
        id = event.calendarItemIdentifier
        title = event.title
        dueDate = date
        notes = event.notes
        isComplete = event.isCompleted
    }
}
