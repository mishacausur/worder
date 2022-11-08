//
//  NetworkService.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import Foundation

final class NetworkService {
    
    typealias wordsResult = ((Result<[WordModel], AppError>) async -> Void)?
    let loader = LoadService()
   
    func getWords(handler: wordsResult) async {
        guard let url = URL(string: Links.words.rawValue) else {
            await handler?(.failure(.badURL))
            return
        }
        do {
            let data = try await URLSession.shared.data(from: url)
            let words = try JSONDecoder().decode([WordModel].self, from: data.0)
            await handler?(.success(words))
        } catch {
            await handler?(.failure(.badResponse))
        }
    }
}

enum Links: String {
    case words = "https://worder-682f4-default-rtdb.firebaseio.com/words.json"

}
