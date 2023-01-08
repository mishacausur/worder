//
//  String.swift
//  worder
//
//  Created by Misha Causur on 20.11.2022.
//

extension String {
    static let words = "Words"
    static let empty = ""
}

extension String {
    public typealias Identity = String
    public var identity: Identity { self }
}
