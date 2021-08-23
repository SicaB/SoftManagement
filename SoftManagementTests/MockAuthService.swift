//
//  MockUserService.swift
//  SoftManagementTests
//
//

@testable import SoftManagement

final class MockAuthentication: AuthenticationProtocol {
    
    var result: Result<Void, Error> = .success(())
    
    var user = User(docId: "", name: "Billy", username: "Bob", email: "BillyBob@gmail.com", password: "123456")
    
    var user2 = User(docId: "", name: "Billy", username: "", email: "BillyBobgmail.com", password: "123456")
    
    func logIn(userEmail: String, userPassword: String, completion: @escaping (Result<Void, Error>, String) -> Void) {
        completion(result, "")
    }
    
    func signUp(name: String, username: String, email: String, password: String, completion: @escaping (Result<Void, Error>, String) -> Void) {
        completion(result, "")
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(result)
    }
    
    func logOut() {
        
    }
    
//    func logIn(userEmail: String, userPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        completion(.success(()))
//    }
    
    
    

}
