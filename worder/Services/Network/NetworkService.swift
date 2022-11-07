//
//  NetworkService.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import Foundation

final class NetworkService {
    
    typealias wordsResult = ((Result<[String: String], AppError>) -> Void)?
    let loader = LoadService()
   
}
