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
    
    var errorDescription: String? {
        switch self {
        case .failedReading:
            return NSLocalizedString("Failed reading data", comment: "Error occured due to data is wrong or unabled to read")
        case .wrongDate:
            return NSLocalizedString("The item has wrong date", comment: "The date can not be parsed correctly")
        case .accessDenied:
            return NSLocalizedString("The app doesn't have permission to read reminders", comment: "Access granted needed")
        }
    }
}
