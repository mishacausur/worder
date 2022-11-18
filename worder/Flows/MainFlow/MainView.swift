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
    private let label = UILabel().configure {
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let textField = UITextField().configure {
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let button = UIButton().configure {
        $0.backgroundColor = .darkGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let countButton = UIButton().configure {
        $0.setTitle("increase counter", for: .normal)
        $0.backgroundColor = .orange
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let counter = UILabel().configure {
        $0.textColor = .orange
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private(set) var text = BehaviorRelay<String>(value: "")
    private let buttonSubject = PublishSubject<String>()
    private var countText = 0
    
    override func addViews() {
        addViews(label, textField, button, countButton, counter)
    }
    
    override func bindViews() {
        labelRecognizer()
        textField.rx.text
            .orEmpty
            .bind(to: text)
            .disposed(by: disposeBag)
        
        text
            .asObservable()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        textField.rx.text.bind { [weak self] in
            self?.label.text = $0
        }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .map { "Button tapped" }
            .bind(to: buttonSubject)
            .disposed(by: disposeBag)
        
        countButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.countText += 1
                self?.counter.text = String(describing: self?.countText)
            })
            .disposed(by: disposeBag)
        
        buttonSubject
            .asObservable()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        backgroundColor = .white
        [label, textField, button, countButton].forEach {
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        [textField.centerXAnchor.constraint(equalTo: centerXAnchor),
         textField.centerYAnchor.constraint(equalTo: centerYAnchor),
         textField.heightAnchor.constraint(equalToConstant: 66),
         textField.widthAnchor.constraint(equalToConstant: 144),
         label.centerXAnchor.constraint(equalTo: centerXAnchor),
         label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -44),
         label.heightAnchor.constraint(equalTo: textField.heightAnchor),
         label.widthAnchor.constraint(equalTo:  textField.widthAnchor),
         button.centerXAnchor.constraint(equalTo: centerXAnchor),
         button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 44),
         button.heightAnchor.constraint(equalTo: textField.heightAnchor),
         button.widthAnchor.constraint(equalTo:  textField.widthAnchor),
         countButton.centerXAnchor.constraint(equalTo: centerXAnchor),
         countButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 44),
         countButton.heightAnchor.constraint(equalTo: textField.heightAnchor),
         countButton.widthAnchor.constraint(equalTo:  textField.widthAnchor),
         counter.centerXAnchor.constraint(equalTo: centerXAnchor),
         counter.topAnchor.constraint(equalTo: countButton.bottomAnchor, constant: 12)].forEach { $0.isActive = true }
    }
    
    private func labelRecognizer() {
        let gesture = UITapGestureRecognizer()
        label.addGestureRecognizer(gesture)
        label.isUserInteractionEnabled = true
        gesture.rx.event
            .asDriver()
            .drive(onNext: { [weak self] in
                print($0)
                self?.textField.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
