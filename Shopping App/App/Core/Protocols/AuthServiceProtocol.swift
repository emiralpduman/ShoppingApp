import Foundation

protocol AuthServiceProtocol {
    func signIn(email: String, password: String, completion: @escaping (String?, Error?) -> Void)
    func signUp(email: String, password: String, completion: @escaping (String?, Error?) -> Void)
    func signOut() throws
    var currentUserUid: String? { get }
    var currentUserEmail: String? { get }
}
