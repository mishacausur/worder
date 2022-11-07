//
//  Configurable.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.UIView

protocol Configurable {}

extension Configurable where Self: UIView {
    
    @discardableResult
    func configure(_ block: (Self) throws -> Void) rethrows -> Self {
        try block(self)
        return self
    }
}
