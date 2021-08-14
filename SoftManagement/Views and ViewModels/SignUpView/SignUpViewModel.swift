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
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "h1") ?? .white]
        UINavigationBar.appearance().backgroundColor = UIColor(named: "backgroundgray")
        
    }
    
}
