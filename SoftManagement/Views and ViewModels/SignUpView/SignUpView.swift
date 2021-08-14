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
    @Environment(\.presentationMode) var mode
    
    var placeholder : [String] = Placeholders.placeholders
    
    var body: some View {
        ZStack{
            VStack() {
                Text("Personal Info")
                    .foregroundColor(Color(.white))
                    .padding(.top, 160)
                    .padding(.leading, 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack() {

                        VStack(alignment: .leading, spacing: 18){
                            
                            ZStack(alignment: .leading){
                                if authentication.user.name.isEmpty {
                                    Text(placeholder[0])
                                        .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $authentication.user.name)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            VStack{
                                Divider().background(Color("h2"))
                            }
                            
                            ZStack(alignment: .leading){
                                if authentication.user.username.isEmpty {
                                    Text(placeholder[1])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $authentication.user.username)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }
                           
                            ZStack(alignment: .leading){
                                if authentication.user.email.isEmpty {
                                    Text(placeholder[2])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $authentication.user.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }

                            ZStack(alignment: .leading){
                                if authentication.user.password.isEmpty {
                                    Text(placeholder[3])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                SecureField("", text: $authentication.user.password)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }
                            
                            
                            Button {
                                authentication.signUp(name: authentication.user.name, username: authentication.user.username, email: authentication.user.email, password: authentication.user.password)
                                    
                            } label: {
                                Text("Save Account")
                                    .foregroundColor(Color("teamcolor1"))
                               
                            }
                            
                        }

                }
                .padding()
                .background(Color("card"))
                .cornerRadius(15)
                .shadow(color: Color("backgroundgray"), radius: 10)
                .padding(.horizontal)
                .foregroundColor(Color("h1"))

                Spacer(minLength: 35)
                
                    VStack(spacing: 8) {
                        Text("Already have an account?")
                            .foregroundColor(Color("h1"))
                        Button{
                            mode.wrappedValue.dismiss()
                        } label: {
                                Text("Login")
                                    .font(.title3)
                                    .foregroundColor(Color("teamcolor1"))
                                
                            }
                        
                        Spacer()
                    }

            }
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                
            }
        }
        .navigationBarTitle("Sign Up")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundgray"))
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
           
    }
}

struct Placeholders {
    static let name = "Name"
    static let username = "Username"
    static let email = "Email"
    static let password = "Password"
    
    static let placeholders = [name, username, email, password]
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SignUpView()
                .environmentObject(Authentication())
        }

    }
}
