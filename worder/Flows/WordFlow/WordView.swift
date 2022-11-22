//
//  WordView.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import UIKit
/*
final class WordView: Viеw {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        .configure {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let collectionLayout = UICollectionViewLayout()
    
    override func configure() {
        backgroundColor = .orange
        collectionView.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.identifier)
        collectionView.collectionViewLayout = collectionLayout
        super.configure()
    }
    
    override func addViews() {
        addViews(collectionView)
    }
    
    override func layout() {
        [collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
         collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
         widthAnchor.constraint(equalToConstant: 100),
         heightAnchor.constraint(equalToConstant: 100)].forEach { $0.isActive = true }
    }
}
*/
final class WordView: Viеw {
    
    lazy var tableView = UITableView().configure { $0.translatesAutoresizingMaskIntoConstraints = false }
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar { searchController.searchBar }
    
    override func configure() {
        backgroundColor = .white
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        super.configure()
    }
    
    override func addViews() {
        addViews(tableView)
    }
    
    override func layout() {
        [tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
         tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: trailingAnchor)].forEach { $0.isActive = true }
    }
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "mishacausur"
        searchBar.placeholder = "what are you looking for?"
        tableView.tableHeaderView = searchController.searchBar
        
    }
}
