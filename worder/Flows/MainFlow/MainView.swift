//
//  MainView.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//
import RxCocoa
import RxSwift
import UIKit

final class MainView: Viеw {
    
    // MARK: - UI
    private let textField = UITextField().configure {
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 1
        $0.translatesAutoresizingMaskIntoConstraints = false }
    private let button = UIButton().configure {
        $0.backgroundColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private(set) var text = BehaviorRelay<String>(value: "")
    
    override func addViews() {
        addViews(textField, button)
    }
    
    override func bindViews() {
        textField.rx.text
            .orEmpty
            .bind(to: text)
            .disposed(by: disposeBag)
        
        text.asObservable().subscribe(onNext: { print($0) }).disposed(by: disposeBag)
        
    }
    
    override func layout() {
        backgroundColor = .white
        [textField, button].forEach {
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        [textField.centerXAnchor.constraint(equalTo: centerXAnchor),
         textField.centerYAnchor.constraint(equalTo: centerYAnchor),
         textField.heightAnchor.constraint(equalToConstant: 66),
         textField.widthAnchor.constraint(equalToConstant: 144),
         button.centerXAnchor.constraint(equalTo: centerXAnchor),
         button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 44),
         button.heightAnchor.constraint(equalTo: textField.heightAnchor),
         button.widthAnchor.constraint(equalTo:  textField.widthAnchor)].forEach { $0.isActive = true }
    }
}
