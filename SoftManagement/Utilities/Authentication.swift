//
//  SignedInState.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 15/06/2021.
//

import SwiftUI
import FirebaseAuth

final class Authentication: ObservableObject {
 
    @Published var user = User()
    @Published var signedIn = false
    @Published var alertItem: AlertItem?
    
    let auth = Auth.auth()
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func logIn(userEmail: String, userPassword: String) {
        
        auth.signIn(withEmail: userEmail,
                    password: userPassword) { [weak self] (result,
                        error) in
            
            if error != nil {
                self?.alertItem = AlertContext.invalidLogin
               
                print(error?.localizedDescription ?? "")
                
            } else {

                print("Succes!")
               
            guard result != nil, error == nil else {
                print("error 1")
                return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
            
        }
    }
    
}
    
    func logOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
    func signUp(name: String, username: String, email: String, password: String) {
        // check if the form has been correctly filled
        guard isValidForm else { return }
        auth.createUser(withEmail: email, password: password) { [weak self] (result, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
                self?.alertItem = AlertContext.emailAlreadyInUse
            } else {
                print("Succes! You are signed in: ", "\(String(describing: self?.signedIn))")
                // TODO: go to the right page...
            }
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                // Success
                self?.signedIn = true
            }
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                self.alertItem = AlertContext.resetPasswordEmailSent
            } else {
                self.alertItem = AlertContext.invalidEmailEnteredForReset
            }
            
        }
    }
    
    var isValidForm: Bool {
        guard !user.name.isEmpty && !user.username.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
            
        }
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        guard user.password.count >= 6 else {
            alertItem = AlertContext.invalidPassword
            return false
        }
        return true
    }
    

}
