//
//  ReminderStore.swift
//  worder
//
//  Created by Misha Causur on 15.01.2023.
//

import Foundation
import class EventKit.EKEventStore
import class EventKit.EKReminder

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let store = EKEventStore()
    
    var isAvailable: Bool {
        EKEventStore.authorizationStatus(for: .reminder) == .authorized
    }
    
    func grantAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .notDetermined:
            let access = try await store.requestAccess(to: .reminder)
            guard access else {
                throw EventError.accessDenied
            }
        case .restricted:
            throw EventError.accessRestricted
        case .denied:
            throw EventError.accessDenied
        case .authorized:
            return
        @unknown default:
            throw EventError.unknowned
        }
    }
    
    func read() async throws -> [Reminder] {
        guard isAvailable else {
            throw EventError.accessDenied
        }
        let predicate = store.predicateForReminders(in: nil)
        let events = try await store.fetchItems(matching: predicate)
        let items: [Reminder] = try events.compactMap {
            do {
                return try Reminder(with: $0)
            } catch EventError.wrongDate {
                return nil
            }
        }
        return items
    }
    
    @discardableResult
    func save(_ reminder: Reminder) throws -> Reminder.ID {
        guard isAvailable else {
            throw EventError.accessDenied
        }
        let item: EKReminder
        do {
            item = try read(with: reminder.id)
        } catch {
            item = EKReminder(eventStore: store)
        }
        item.update(using: reminder, in: store)
        try store.save(item, commit: true)
        return item.calendarItemIdentifier
    }

    private func read(with id: Reminder.ID) throws -> EKReminder {
        guard let reminder = store.calendarItem(withIdentifier: id) as? EKReminder else {
            throw EventError.failedReadingCalendarItem
        }
        return reminder
    }
}
