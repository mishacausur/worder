//
//  TodayItemViewController+CellConfiguration.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import Foundation.NSDate
import struct UIKit.UIListContentConfiguration
import class UIKit.UICollectionViewListCell
import class UIKit.UIFont

extension TodayItemViewController {
    
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var conf = cell.defaultContentConfiguration()
        conf.text = getText(for: row)
        conf.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        conf.image = row.image
        return conf
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var conf = cell.defaultContentConfiguration()
        conf.text = title
        return conf
    }
    
    func getText(for row: Row) -> String? {
        switch row {
        case .date:
            return reminder.dueDate.dayText
        case .note:
            return reminder.notes
        case .time:
            return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title:
            return reminder.title
        default:
            return nil
        }
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var conf = cell.textFieldConfiguration()
        conf.text = title
        conf.onChange = { [weak self] in
            self?.workingReminder.title = $0
        }
        
        return conf
    }
    
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var conf = cell.datePickerConfiguration()
        conf.date = date
        conf.onChange = { [weak self] in
            self?.workingReminder.dueDate = $0
        }
        
        return conf
    }
    
    func textConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
        var conf = cell.textViewConfiguration()
        conf.title = notes
        conf.onChange = { [weak self] in
            self?.workingReminder.notes = $0
        }
        return conf
    }
}
