//
//  SignedInState.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 15/06/2021.
 

import SwiftUI
import FirebaseAuth

protocol AuthenticationProtocol {
    func logIn(userEmail: String, userPassword: String, completion: @escaping (Result<Void, Error>, String) -> Void)
    func signUp(name: String, username: String, email: String, password: String, completion: @escaping (Result<Void, Error>, String) -> Void)
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void)
    func logOut()
}

final class Authentication: ObservableObject, AuthenticationProtocol {
 
   // @Published var user = User(docId: "")
    @Published var signedIn = false
  //  @Published var alertItem: AlertItem?
   // @Published var repository = ProjectRepository()
    @Published var userId = ""

    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func logIn(userEmail: String, userPassword: String, completion: @escaping (Result<Void, Error>, String) -> Void) {
        auth.signIn(withEmail: userEmail,
                    password: userPassword) { [weak self] (result,
                        error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error), "")
            } else {
                print("Succes!")
                completion(.success(()), self!.auth.currentUser!.uid)
               
            guard result != nil, error == nil else {
                print("error 1")
                return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
                self?.userId = self!.auth.currentUser!.uid
            }
        }
    }
    
}
    
    func logOut() {
        try? auth.signOut()
        self.signedIn = false
        self.userId = ""
    }
    
    func signUp(name: String, username: String, email: String, password: String, completion: @escaping (Result<Void, Error>, String) -> Void) {
        // check if the form has been correctly filled
        auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error), "")
            } else {
                print("Succes! You are signed in: ", "\(String(describing: self?.signedIn))")
                completion(.success(()), self!.auth.currentUser!.uid)
            }
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
                self?.userId = self!.auth.currentUser!.uid
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    

}
