//
//  AccountViewModel.swift
//  SoftManagement
//
//

//
//  SignUpViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 07/06/2021.
//

import SwiftUI
import FirebaseAuth
//import Combine

final class AccountViewModel: ObservableObject {
    
    private let authentication: AuthenticationProtocol
    @Published var signedOut = false
 
    init(authentication: AuthenticationProtocol = Authentication()) {
        self.authentication = authentication
    }
    
    func send(action: Action) {
        switch action {
        case .logOut:
            authentication.logOut()
            signedOut = true
        
        case .errorConfirm:
            break
        }
    }
    

        enum Action {
            case logOut
            case errorConfirm
            
        }
    
}

