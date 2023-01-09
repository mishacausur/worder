//
//  TextFieldContentView.swift
//  worder
//
//  Created by Misha Causur on 09.01.2023.
//

import CoreGraphics.CGGeometry
import class Foundation.NSCoder
import class UIKit.UITextField
import class UIKit.UIView
import class UIKit.UICollectionViewListCell
import protocol UIKit.UIContentView
import protocol UIKit.UIContentConfiguration

final class TextFieldContentView: UIView, UIContentView {
    
    let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        .init(width: 0, height: 44)
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        addPinnedSubview(textField, insets: .init(top: 0, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
        textField.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
    
    @objc private func didChange(_ sender: UITextField) {
        guard let configuration = configuration as? Configuration else { return }
        configuration.onChange(textField.text ?? .empty)
    }
    
}

extension TextFieldContentView {
    
    struct Configuration: UIContentConfiguration {
        
        var text: String? = .empty
        var onChange: (String) -> Void = { _ in }
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }
}

extension UICollectionViewListCell {
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
        .init()
    }
}
