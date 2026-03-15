import Foundation
@testable import Shopping_App

final class MockAuthService: AuthServiceProtocol {
    var signInResult: (String?, Error?) = (nil, nil)
    var signUpResult: (String?, Error?) = (nil, nil)
    var currentUserUid: String?
    var currentUserEmail: String?

    func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        completion(signInResult.0, signInResult.1)
    }

    func signUp(email: String, password: String, completion: @escaping (String?, Error?) -> Void) {
        completion(signUpResult.0, signUpResult.1)
    }

    func signOut() throws { }
}
