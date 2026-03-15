//
//  AuthViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import RealmSwift

protocol AuthViewModelDelegate: AnyObject {
    func didErrorOccur(error: Error)
    func didSignUpSuccesfully()
    func didSignInSuccesfully()
    func willRequestService()
}

final class AuthViewModel: RealmReachable {
    var injectedRealm: Realm?
    weak var delegate: AuthViewModelDelegate?
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = FirebaseAuthService()) {
        self.authService = authService
    }

    func signIn(email: String, password: String) {
        delegate?.willRequestService()
        authService.signIn(email: email, password: password) { [weak self] uid, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.didErrorOccur(error: error)
            } else {
                let users = self.realm.objects(UserEntity.self)

                let isNotInDatabase = !users.contains(where: { $0.emailAddress == email })

                if isNotInDatabase {
                    let user = UserEntity()
                    user.emailAddress = self.authService.currentUserEmail ?? email
                    user._id = uid ?? ""
                    user.userName = self.authService.currentUserEmail ?? email

                    do {
                        try self.realm.write {
                            self.realm.add(user)
                            self.delegate?.didSignInSuccesfully()
                        }
                    } catch {
                        self.delegate?.didErrorOccur(error: AuthViewModelError.cannotWriteToDb)
                    }
                }
                self.delegate?.didSignInSuccesfully()
            }
        }
    }

    func signUp(email: String, password: String, userName: String) {
        delegate?.willRequestService()
        authService.signUp(email: email, password: password) { [weak self] uid, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.didErrorOccur(error: error)
            } else {
                self.delegate?.didSignUpSuccesfully()
            }

            guard let uid = uid else {
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
