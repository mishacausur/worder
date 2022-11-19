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
    private let slider = UISlider().configure {
        $0.tintColor = .orange
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let progress = UIProgressView(progressViewStyle: .bar).configure {
        $0.tintColor = .green
        $0.progressTintColor = .orange
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
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
    private let progressLable = UILabel().configure {
        $0.textColor = .orange
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - PROPERTIES
    private let disposeBag = DisposeBag()
    private(set) var text = BehaviorRelay<String>(value: "")
    private let buttonSubject = PublishSubject<String>()
    private var countText = 0
    
    override func addViews() {
        addViews(label,
                 textField,
                 button,
                 countButton,
                 counter,
                 slider,
                 progress,
                 progressLable)
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
/*
        slider.rx.value
            .asDriver()
            .drive(progress.rx.progress)
            .disposed(by: disposeBag)
        
        slider.rx.value
            .asDriver()
            .map { String(describing: Int($0 * 100)) }
            .drive(progressLable.rx.text)
            .disposed(by: disposeBag)
 */
        
        slider.rx.value
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.progressLable.textColor = $0 > 0.5 ? .white : .orange
                self?.progress.progress = $0
                self?.progressLable.text = "\(Int($0 * 100))%"
            })
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        backgroundColor = .white
        [label, textField, button, countButton]
            .forEach {
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
        
        [slider.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 44),
         slider.centerXAnchor.constraint(equalTo: centerXAnchor),
         slider.widthAnchor.constraint(equalToConstant: 300),
         progress.topAnchor.constraint(equalTo: counter.bottomAnchor, constant: 22),
         progress.leadingAnchor.constraint(equalTo: leadingAnchor),
         progress.trailingAnchor.constraint(equalTo: trailingAnchor),
         progress.heightAnchor.constraint(equalToConstant: 44),
         progressLable.centerXAnchor.constraint(equalTo: progress.centerXAnchor),
         progressLable.centerYAnchor.constraint(equalTo: progress.centerYAnchor),
         textField.centerXAnchor.constraint(equalTo: centerXAnchor),
         textField.centerYAnchor.constraint(equalTo: centerYAnchor),
         textField.heightAnchor.constraint(equalToConstant: 66),
         textField.widthAnchor.constraint(equalToConstant: 244),
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
