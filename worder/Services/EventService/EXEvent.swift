//
//  EXEvent.swift
//  worder
//
//  Created by Misha Causur on 15.01.2023.
//

import Foundation
import class EventKit.EKReminder
import class EventKit.EKEventStore

extension EKEventStore {
    func fetchItems(matching predicate: NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) {
                if let reminders = $0 {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: EventError.failedReading)
                }
            }
        }
    }
}
