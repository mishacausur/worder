//
//  TodayItemViewController+Row.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import class UIKit.UIImage
import class UIKit.UIFont

extension TodayItemViewController {
    enum Row: Hashable {
        case date
        case note
        case time
        case title
        
        var imageName: String? {
            switch self {
            case .date:
                return "calendar.circle"
            case .note:
                return "square.and.pencil"
            case .time:
                return "clock"
            default:
                return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else {
                return nil
            }
            let conf = UIImage.SymbolConfiguration(textStyle: .headline)
            return .init(systemName: imageName, withConfiguration: conf)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title:
                return .headline
            default:
                return .subheadline
            }
        }
    }
}
