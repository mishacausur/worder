//
//  DataManager.swift
//  worder
//
//  Created by Misha Causur on 09.11.2022.
//

import Firebase
import FirebaseDatabase
import FirebaseFirestore
import CoreMedia

final class DataManager {
    
    private func configure() -> Firestore {
        Firestore.firestore().settings = .init()
        return Firestore.firestore()
    }
    
    func getWords(handler: ((Result<[WordModel], DataError>) -> Void)?) {
        let database = configure()
        database.collection("words").getDocuments {
            guard $1 == nil else {
                handler?(.failure(.noData))
                return
            }
            print($0)
        }
    }
}

enum DataError: Error {
    case noData
}
