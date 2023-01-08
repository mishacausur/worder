//
//  TodayItemrViewController+Section.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import Foundation

extension TodayItemViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case note
        
        var name: String {
            switch self {
            case .view:
                return .empty
            case .title:
                return NSLocalizedString("Title", comment: "title section")
            case .date:
                return NSLocalizedString("Date", comment: "date section")
            case .note:
                return NSLocalizedString("Note", comment: "note section")
            }
        }
    }
}
