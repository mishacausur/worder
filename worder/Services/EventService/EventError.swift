//
//  EventError.swift
//  worder
//
//  Created by Misha Causur on 15.01.2023.
//

import Foundation

enum EventError: LocalizedError {
    case failedReading
    case wrongDate
    case accessDenied
    case accessRestricted
    case unknowned
    case failedReadingCalendarItem
    
    var errorDescription: String? {
        switch self {
        case .failedReading:
            return NSLocalizedString("Failed reading data", comment: "Error occured due to data is wrong or unabled to read")
        case .wrongDate:
            return NSLocalizedString("The item has wrong date", comment: "The date can not be parsed correctly")
        case .accessDenied:
            return NSLocalizedString("The app doesn't have permission to read reminders", comment: "Access granted needed")
        case .accessRestricted:
            return NSLocalizedString("The permission was restricted", comment: "Access granted needed")
        case .unknowned:
            return NSLocalizedString("Unknowned error has occured", comment: "Unknown")
        case .failedReadingCalendarItem:
            return NSLocalizedString("Failed to read a calendar item.", comment: "failed reading calendar item error description")
        }
    }
}
