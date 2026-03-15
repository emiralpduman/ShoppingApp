import Foundation
import FirebaseAuth

final class FirebaseAuthService: AuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(authResult?.user.uid, error)
        }
    }

    func signUp(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(authResult?.user.uid, error)
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    var currentUserUid: String? {
        Auth.auth().currentUser?.uid
    }

    var currentUserEmail: String? {
        Auth.auth().currentUser?.email
    }
}
