//
//  AnimatedSectionModel.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    
    typealias Item = String
    typealias Identity = String
    
    var identity: Identity { title }
    var items: [Item] { data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
}


