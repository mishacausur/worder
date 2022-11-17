//
//  Completion.swift
//  worder
//
//  Created by Misha Causur on 17.11.2022.
//

import Foundation

public func example(_ rxOperator: String, completion: () -> ()) {
    print("\n--- it's working \(rxOperator) ---\n")
    completion()
}
