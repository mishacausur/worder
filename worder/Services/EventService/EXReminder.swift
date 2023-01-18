//
//  EXReminder.swift
//  worder
//
//  Created by Misha Causur on 18.01.2023.
//

import Foundation
import class EventKit.EKReminder
import class EventKit.EKEventStore
import class EventKit.EKAlarm

extension EKReminder {
    func update(using reminder: Reminder, in store: EKEventStore) {
        title = reminder.title
        notes = reminder.notes
        isCompleted = reminder.isComplete
        calendar = store.defaultCalendarForNewReminders()
        alarms?.forEach {
            guard let absoluteDate = $0.absoluteDate else { return }
            let comp = Locale.current.calendar.compare(reminder.dueDate, to: absoluteDate, toGranularity: .minute)
            if comp != .orderedSame {
                removeAlarm($0)
            }
        }
        if !hasAlarms {
            addAlarm(EKAlarm(absoluteDate: reminder.dueDate))
        }
    }
}
