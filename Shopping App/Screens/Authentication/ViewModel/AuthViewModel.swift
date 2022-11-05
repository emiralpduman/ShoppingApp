//
//  AuthViewModel.swift
//  Shopping App
//
//  Created by Emiralp Duman on 4.11.2022.
//

import Foundation
import FirebaseAuth
import RealmSwift


final class AuthViewModel: RealmReachable {
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                print("Sign-in is succesful")
            }
        }
        
    }
    
    
    func signUp(email: String, password: String, userName: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
            } else {
                print("Sign-up is succesful")
            }
            
            guard let uid = authResult?.user.uid else {
                fatalError()
            }
            
            let user = UserEntity()
            user._id = uid
            user.userName = userName
            user.emailAddress = email
            
            do {
                try self.realm.write {
                    self.realm.add(user)
                    print("User is created.")
                }
            } catch {
                print("User cannot be created.")
            }
        

            
//            let user = User(email: (authResult?.user.email)!)
//
//            do {
//                guard let data = try user.dictionary,
//                      let id = authResult?.user.uid else {
//                    return
//                }
//
//                self.defaults.set(id, forKey: "uid")
//
//                self.db.collection("users").document(id).setData(data) { error in
//
//                    if let error = error {
//                        self.changeHandler?(.didErrorOccurred(error))
//                    } else {
//                        self.changeHandler?(.didSignUpSuccessful)
//                    }
//                }
//            } catch {
//                self.changeHandler?(.didErrorOccurred(error))
//            }
        }
    }
}
