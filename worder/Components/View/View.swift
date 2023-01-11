//
//  View.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import UIKit.UIView

class Viеw: UIView {
    
    var present: (UIViewController) -> Void = { _ in }
    var dismiss: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addViews()
        layout()
        bindViews()
    }
    
    func bindViews() {
    }
    
    func addViews() {
    }
    
    func layout() {
    }
}
