//
//  TempEntities.swift
//  worder
//
//  Created by Misha Causur on 22.11.2022.
//

import Foundation
import RxSwift

final class APIProvider {
    
    func getRepos(_ id: String) -> Observable<[Repository]> {
        guard !id.isEmpty,
              let url = URL(string: "https://api.github.com/users/\(id)/repos") else {
            return Observable.just([])
        }
        return URLSession.shared
            .rx.json(request: URLRequest(url: url))
            .retry(3)
            .map {
                var repos = [Repository]()
                if let items = $0 as? [[String: AnyObject]] {
                    items.forEach {
                        guard let name = $0["name"] as? String,
                              let url = $0["html_url"] as? String
                        else {
                            return
                        }
                        repos.append(Repository(name: name, url: url))
                    }
                }
                return repos
            }
    }
}

struct Repository {
    let name: String
    let url: String
}
