//
//  SignUpViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 07/06/2021.
//

import SwiftUI
import FirebaseAuth
//import Combine

final class LogInViewModel: ObservableObject {
    
    var usernamePlaceholder = "Email"
    var passwordPlaceholder = "Password"
    
    @Published var user = User(docId: "", name: "", username: "", email: "", password: "")
    @Published var signedIn = false
    @Published var userId = ""
    @Published var error: Error?
    @Published var alertItem: AlertItem?
    @Published var emailSend = false
    
    private let authentication: AuthenticationProtocol
 
    init(authentication: AuthenticationProtocol = Authentication()) {
        self.authentication = authentication
    }
    
    func send(action: Action) {
        switch action {
        case .login:
            authentication.logIn(userEmail: user.email, userPassword: user.password) { (result, userId) in
                switch result {
                case .success:
                    self.signedIn = true
                    self.userId = userId
                case let .failure(error):
                    self.error = error
                    self.alertItem = AlertContext.invalidLogin
                    
                }
            }
            case .errorConfirm:
                break
            case .forgotPassword:
                authentication.forgotPassword(email: user.email) { result in
                    switch result {
                    case .success:
                        self.emailSend = true
                        self.alertItem = AlertContext.resetPasswordEmailSent
                    case let .failure(error):
                        self.error = error
                        self.alertItem = AlertContext.invalidEmailForReset
                        
                    }
                }
        }
    }
    

        enum Action {
            case login
            case forgotPassword
            case errorConfirm
            
        }
    
}
