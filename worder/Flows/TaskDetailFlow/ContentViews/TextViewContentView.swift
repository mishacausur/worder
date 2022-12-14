//
//  TextViewContentView.swift
//  worder
//
//  Created by Misha Causur on 09.01.2023.
//

import CoreGraphics.CGGeometry
import class Foundation.NSCoder
import class UIKit.UITextView
import class UIKit.UIView
import class UIKit.UICollectionViewListCell
import protocol UIKit.UIContentView
import protocol UIKit.UIContentConfiguration
import protocol UIKit.UITextViewDelegate

final class TextViewContentView: UIView & UIContentView {
    
    struct Configuration: UIContentConfiguration {
        
        var title: String? = .empty
        var onChange: (String) -> Void = { _ in }
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    private let textView = UITextView()
    
    override var intrinsicContentSize: CGSize {
        .init(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addPinnedSubview(textView, height: 200)
        textView.backgroundColor = nil
        textView.font = .preferredFont(forTextStyle: .body)
        textView.delegate = self
    }
    
    func configure(_ configuration: UIContentConfiguration) {
        guard let conf = configuration as? Configuration else { return }
        textView.text = conf.title
    }
}

extension TextViewContentView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let conf = configuration as? Configuration else { return }
        conf.onChange(textView.text)
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration() -> TextViewContentView.Configuration {
        TextViewContentView.Configuration()
    }
}
