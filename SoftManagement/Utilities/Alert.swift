//
//  AlertContext.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 15/06/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // MARK: - Account Alerts
    static let invalidForm = AlertItem(title: "Invalid Form",
                                    message: "Please ensure all fields in the form have been filled out", dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: "Invalid Email",
                                    message: "Please ensure your email is correct", dismissButton: .default(Text("OK")))
    
    static let invalidPassword = AlertItem(title: "Invalid Password",
                                    message: "Your password has to be at least 6 caracters long", dismissButton: .default(Text("OK")))
    
    static let emailAlreadyInUse = AlertItem(title: "Invalid Email",
                                        message: "The email address is already in use by another account", dismissButton: .default(Text("OK")))
    
    static let invalidLogin = AlertItem(title: "Invalid Login",
                                    message: "Wrong Email or password", dismissButton: .default(Text("OK")))
    
    static let invalidEmailEnteredForReset = AlertItem(title: "Invalid Email",
                                        message: "We could not find the email in the database. Please make sure the email is correct!", dismissButton: .default(Text("OK")))
    
    static let resetPasswordEmailSent = AlertItem(title: "Email has been sent",
                                        message: "You can now reset your password!", dismissButton: .default(Text("OK")))
    
    
}
