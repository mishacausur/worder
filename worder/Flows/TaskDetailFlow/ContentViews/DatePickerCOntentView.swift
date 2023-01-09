//
//  DatePickerCOntentView.swift
//  worder
//
//  Created by Misha Causur on 09.01.2023.
//

import CoreGraphics.CGGeometry
import Foundation.NSDate
import class Foundation.NSCoder
import class UIKit.UIDatePicker
import class UIKit.UIView
import class UIKit.UICollectionViewListCell
import protocol UIKit.UIContentView
import protocol UIKit.UIContentConfiguration

final class DatePickerContentView: UIView & UIContentView {
    
    struct Configuration: UIContentConfiguration {
        
        var date = Date.now
        
        func makeContentView() -> UIView & UIContentView {
            DatePickerContentView(self)
        }
    }
    
    private let datePicker = UIDatePicker()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ configuration: UIContentConfiguration) {
        guard let conf = configuration as? Configuration else { return }
        datePicker.date = conf.date
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
