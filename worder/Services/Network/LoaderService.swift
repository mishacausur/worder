//
//  LoaderService.swift
//  worder
//
//  Created by Misha Causur on 07.11.2022.
//

import Foundation

struct LoadService {
    
    func load<T: Decodable>(url: URL, completion: @escaping (Result<T, AppError>) -> Void) async throws {
        let response = try await URLSession.shared.data(from: url)
        let data = try JSONDecoder().decode(T.self, from: response.0)
        completion(.success(data))
    }
}
