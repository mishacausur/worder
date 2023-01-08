//
//  TodayItemViewController.swift
//  worder
//
//  Created by Misha Causur on 08.01.2023.
//

import class UIKit.UICollectionViewController
import UIKit.UICollectionLayoutList

final class TodayItemViewController: UICollectionViewController {
    
    var reminder: Reminder
    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConf = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConf.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConf)
        super.init(collectionViewLayout: listLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize TodayItemViewController using init(reminder:)")
    }
}
