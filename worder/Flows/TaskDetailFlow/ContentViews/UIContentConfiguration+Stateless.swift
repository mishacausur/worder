//
//  UIContentConfiguration+Stateless.swift
//  worder
//
//  Created by Misha Causur on 09.01.2023.
//

import protocol UIKit.UIContentConfiguration
import protocol UIKit.UIConfigurationState


extension UIContentConfiguration {
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
