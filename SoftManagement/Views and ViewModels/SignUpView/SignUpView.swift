//
//  SignUpView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 09/06/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
            ZStack() {
                VStack {
                Form {
                    Section(header: Text("Personal Info")) {
                        TextField("Name", text: $authentication.user.name)
                            .disableAutocorrection(true)
                        TextField("Username", text: $authentication.user.username)
                            .disableAutocorrection(true)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        TextField("Email", text: $authentication.user.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .disableAutocorrection(true)
                        SecureField("Password", text: $authentication.user.password)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .disableAutocorrection(true)
                        
                        
                        Button {
                            authentication.signUp(name: authentication.user.name, username: authentication.user.username, email: authentication.user.email, password: authentication.user.password)
                        } label: {
                            Text("Save Account")
                           
                        }
                        
                    }
                }
                    
                }
                .navigationBarTitle("Sign Up")
                .background(Color("h2"))
                
            }
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                
            }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SignUpView()
                .environmentObject(Authentication())
        }

    }
}
