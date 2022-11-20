//
//  DetailView.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit
import RxCocoa

final class DetailView: Viеw {
    lazy var tableView = UITableView().configure { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    override func configure() {
        backgroundColor = .white
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        super.configure()
    }
    
    override func addViews() {
        addViews(tableView)
    }
    
    override func layout() {
        [tableView.topAnchor.constraint(equalTo: topAnchor),
         tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: trailingAnchor)].forEach { $0.isActive = true }
    }
}
