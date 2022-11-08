//
//  WordType.swift
//  worder
//
//  Created by Misha Causur on 09.11.2022.
//

enum WordType: Codable {
    
    case noun
    case verb
    case adjective
    case idiom
    
    private enum CodingKeys: String, CodingKey {
        case noun, verb, adjective, idiom
    }
}
