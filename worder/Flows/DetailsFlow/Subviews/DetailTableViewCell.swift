//
//  DetailTableViewCell.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    private let wordLabel = UILabel().configure {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let translationLabel = UILabel().configure { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    static var identifier: String {
        "DetailCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        layout()
    }
    
    required init?(coder: NSCoder)  {
        super.init(coder: coder)
    }

    
    private func addViews() {
        addViews(wordLabel, translationLabel)
    }
    
    private func layout() {
        [wordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
         wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
         translationLabel.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 8),
         translationLabel.leadingAnchor.constraint(equalTo: wordLabel.leadingAnchor),
         translationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)].forEach { $0.isActive = true}
    }
    
    func configureLabels(_ word: WordModel) {
        wordLabel.text = word.word
        translationLabel.text = word.translation
    }
    
    /// temp
    func configureLabels(_ repository: Repository) {
        wordLabel.text = repository.name
        translationLabel.text = repository.url
    }
}
