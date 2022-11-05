//
//  AuthViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import FirebaseAuth
import RealmSwift

protocol AuthViewModelDelegate {
    func didErrorOccur(error: Error)
    func didSignUpSuccesfully()
    func didSignInSuccesfully()
    func willRequestService()
}


final class AuthViewModel: RealmReachable {
    var delegate: AuthViewModelDelegate?
    
    func signIn(email: String, password: String) {
        delegate?.willRequestService()
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.delegate?.didErrorOccur(error: error)
            } else {
                self.delegate?.didSignInSuccesfully()
            }
        }
    }
     
    
    func signUp(email: String, password: String, userName: String) {
        delegate?.willRequestService()
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.delegate?.didErrorOccur(error: error)
            } else {
                self.delegate?.didSignUpSuccesfully()
            }
            
            guard let uid = authResult?.user.uid else {
                self.delegate?.didErrorOccur(error: AuthViewModelError.noUid)
                return
            }
            
            let user = UserEntity()
            user._id = uid
            user.userName = userName
            user.emailAddress = email
            
            do {
                try self.realm.write {
                    self.realm.add(user)
                    self.delegate?.didSignUpSuccesfully()
                }
            } catch {
                self.delegate?.didErrorOccur(error: AuthViewModelError.cannotWriteToDb)
            }
        }
    }
}

enum AuthViewModelError: Error {
    case noUid
    case cannotWriteToDb
}

extension AuthViewModelError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noUid:
            return "UID of new user could not be retreived from authentication server."
        case .cannotWriteToDb:
            return "New user could not be written to local database."
        }
    }
}
