//
//  UIView+PinnedSubview.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import CoreGraphics
import UIKit.UIGeometry
import class UIKit.UIView

extension UIView {
    func addPinnedSubview(
        _ subview: UIView,
        height: CGFloat? = nil,
        insets : UIEdgeInsets = .init(
            top: 0,
            left: 8,
            bottom: 0,
            right: 8
        )
    ) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        [subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
         subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
         subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right),
         subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom)].forEach { $0.isActive = true }
        
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
