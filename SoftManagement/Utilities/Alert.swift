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
    
    static let invalidEmailForReset = AlertItem(title: "Invalid Email",
                                        message: "We could not find the email in the database. Please make sure the email is correct!", dismissButton:
                                            .default(Text("OK")))
    
    static let resetPasswordEmailSent = AlertItem(title: "Email has been sent",
                                        message: "You can now reset your password!", dismissButton: .default(Text("OK")))
    
    static let invalidProjectName = AlertItem(title: "No Project Name",
                                        message: "Your project must have a name!", dismissButton: .default(Text("OK")))
    
    static let invalidTimeline = AlertItem(title: "Invalid Timeline",
                                        message: "Your project can not have a deadline before project start date. Make sure the dates are correct!", dismissButton: .default(Text("OK")))
    
    static let invalidTeamName = AlertItem(title: "No Team Name",
                                        message: "Your team must have a name!", dismissButton: .default(Text("OK")))
    
    static let invalidTaskName = AlertItem(title: "No Task Name",
                                        message: "Your task must have a name!", dismissButton: .default(Text("OK")))

    static let invalidTaskWorkload = AlertItem(title: "No Workload",
                                        message: "Enter the estimated number of hours or days the task will take!", dismissButton: .default(Text("OK")))
    
    
}
