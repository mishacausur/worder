//
//  AuthService.swift
//  worder
//
//  Created by Misha Causur on 08.11.2022.
//

import FirebaseAuth

final class AuthService {
    
    typealias handler = ((Result<Bool, AuthError>) -> Void)?
    
    private let auth = Auth.auth()
    private var verification: String?
    
    func start(phone: String, handler: handler) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] in
            guard let verification = $0, $1 == nil else {
                handler?(.failure(.unauth))
                return
            }
            self?.verification = verification
            handler?(.success(true))
        }
    }
    
    func verifyAuth(verificationCode: String, handler: handler) {
        guard let verification = verification else {
            handler?(.failure(.unauth))
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification, verificationCode: verificationCode)
        auth.signIn(with: credential) {
            guard $0 != nil, $1 == nil else {
                handler?(.failure(.unauth))
                return
            }
            handler?(.success(true))
        }
    }
}
