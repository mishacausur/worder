//
//  ProgressiveHeaderView.swift
//  worder
//
//  Created by Misha Causur on 14.01.2023.
//

import Foundation
import UIKit

final class ProgressiveHeaderView: UICollectionReusableView {
    
    static var elementaryKind: String { UICollectionView.elementKindSectionHeader}
    
    private typealias Views = (UIView, UIView, UIView)
    private(set) var progress: CGFloat = 0.0 {
        didSet {
            updateConstraint()
        }
    }
    private lazy var interface = createInterface()
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        interface.container.layer.masksToBounds = true
        interface.container.layer.cornerRadius = interface.container.bounds.width / 2
    }
    
    func prepareSubviews() {
        [
            interface.upperView,
            interface.lowerView
        ]
            .forEach { interface.container.addSubview($0) }
        
        addSubview(interface.container)
        backgroundColor = .clear
        interface.container.backgroundColor = .clear
        interface.upperView.backgroundColor = .todayProgressUpperBackground
        interface.lowerView.backgroundColor = .todayProgressLowerBackground
    }
    
    private func layout() {
        [heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
         interface.container.heightAnchor.constraint(equalTo: interface.container.widthAnchor, multiplier: 1),
         interface.container.centerYAnchor.constraint(equalTo: centerYAnchor),
         interface.container.centerXAnchor.constraint(equalTo: centerXAnchor),
         interface.container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85),
         interface.upperView.topAnchor.constraint(equalTo: topAnchor),
         interface.upperView.bottomAnchor.constraint(equalTo: interface.lowerView.topAnchor),
         interface.lowerView.bottomAnchor.constraint(equalTo: bottomAnchor),
         interface.upperView.leadingAnchor.constraint(equalTo: leadingAnchor),
         interface.upperView.trailingAnchor.constraint(equalTo: trailingAnchor),
         interface.lowerView.leadingAnchor.constraint(equalTo: leadingAnchor),
         interface.lowerView.trailingAnchor.constraint(equalTo: trailingAnchor)].forEach { $0.isActive = true }
        
        heightConstraint = interface.lowerView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
    
    private func updateConstraint() {
        heightConstraint?.constant = progress * bounds.height
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    private struct Interface {
        let upperView: UIView
        let lowerView: UIView
        let container: UIView
    }
    
    private func createInterface() -> Interface {
        let defaultView = UIView()
        var views: Views = (defaultView, defaultView, defaultView)
        
        let creator = Array(0...2).map { _ in return UIView(frame: .zero) }
        creator.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false }
        
        withUnsafeMutablePointer(to: &views) { (bt) -> Void in
            memcpy(bt, creator, 3)
            return
        }
        
        return .init(
            upperView: views.0,
            lowerView: views.1,
            container: views.2
        )
    }
}
