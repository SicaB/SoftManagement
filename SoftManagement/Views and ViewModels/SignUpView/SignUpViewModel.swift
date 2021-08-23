//
//  SignUpViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/06/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

final class SignUpViewModel: ObservableObject {
    
    var placeholder : [String] = Placeholders.placeholders
    
    @Published var user = User(docId: "", name: "", username: "", email: "", password: "")
    @Published var signedIn = false
    @Published var error: Error?
    @Published var alertItem : AlertItem?
    @Published var repository = ProjectRepository()
    @Published var userId = ""
    
    private let authentication: AuthenticationProtocol
    
    init(authentication: AuthenticationProtocol = Authentication()) {
        self.authentication = authentication
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "h1") ?? .white]
        UINavigationBar.appearance().backgroundColor = UIColor(named: "backgroundgray")
        
    }
    
    func send(action: Action) {
        switch action {
        case .signup:
        guard isValidForm else { return }
        authentication.signUp(name: user.name, username: user.username, email: user.email, password: user.password) { (result, userId) in
                switch result {
                case .success:
                    self.repository.saveUser(userId: userId, user: self.user)
                    self.signedIn = true
                    self.userId = userId
                    
                case let .failure(error):
                    self.alertItem = AlertContext.emailAlreadyInUse
                    print("heeey")
                    self.error = error
                }
            }
            case .errorConfirm:
                break
        }
    }
    enum Action {
        case signup
        case errorConfirm
        }
    
    struct Placeholders {
        static let name = "Name"
        static let username = "Username"
        static let email = "Email"
        static let password = "Password"
        
        static let placeholders = [name, username, email, password]
        
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
