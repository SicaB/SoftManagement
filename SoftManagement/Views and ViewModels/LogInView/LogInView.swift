//
//  ContentView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 18/05/2021.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = LogInViewModel()
    @State var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            if authentication.signedIn {
                TabContainerView().environmentObject(self.authentication)

            }
            else {
                LogInScreenView().environmentObject(self.authentication)
                    
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            authentication.signedIn = authentication.isSignedIn
        }
    }
}

struct LogInScreenView: View {
    
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel = LogInViewModel()
    
    var usernamePlaceholder = "Email"
    var passwordPlaceholder = "Password"
    
    var body: some View {
        NavigationView{
            ZStack() {
                //BackgroundColor()
                BackgroundImage(image: "signup")
                    .navigationBarHidden(true)
                
                VStack(alignment: .center) {
                    Spacer().frame(height: 85)
                    
                    Logo()
                    
                    Spacer().frame(height: 140)
                    // Stack to hold textfields and button to login
                    VStack(spacing: 10) {
                        
                        // Email Textfield
                        
                        ZStack (alignment: .leading){
                            if authentication.user.email.isEmpty { Text(usernamePlaceholder)
                                .foregroundColor(Color("lightgray"))
                                .padding()
                                .font(.system(size: 18, weight: .medium, design: .default))
                            }
                            TextField("", text: $authentication.user.email)
                                .padding()
                                .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.white), lineWidth: 2)
                                    
                                    
                                )
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color(.white))
                                .keyboardType(.emailAddress)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .disableAutocorrection(true)
                            
                        }
                        
                        // Secure Textfield
                        ZStack (alignment: .leading){
                            if authentication.user.password.isEmpty { Text(passwordPlaceholder)
                                .foregroundColor(Color("lightgray"))
                                .padding()
                                .font(.system(size: 18, weight: .medium, design: .default))
                            }
                            SecureField("", text: $authentication.user.password)
                                .padding()
                                .ignoresSafeArea(/*@START_MENU_TOKEN@*/.keyboard/*@END_MENU_TOKEN@*/, edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                                .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.white), lineWidth: 2)
                                    
                                )
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color(.white))
   
                        }
                        
                        Button {
                            authentication.forgotPassword(email: authentication.user.email)
                        } label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color("teamcolor1"))
                                .offset(x: 70, y: -5)
                        }
                
                        // Navigation
                        Button {
                            authentication.logIn(userEmail: authentication.user.email, userPassword: authentication.user.password)
                        }
                        label: {
                            SoftBtn(title: "LOG IN", textColor: .white, backgroundColor: Color("teamcolor1"), opacity: 0.8)

                        }
                        
                    }
                    
                    // Stack to hold signup option
                    VStack(spacing: 8) {
                        Text("Don't have an account?")
                            .foregroundColor(Color("h1"))
                        NavigationLink(
                            destination: SignUpView().environmentObject(self.authentication),
                            label: {
                                SoftBtn(title: "SIGN UP", textColor: Color("teamcolor1"), backgroundColor: .white, opacity: 0.95)
                                
                            })
                    }.padding(.top, 20)
                    
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundgray"))
            .ignoresSafeArea(edges: .all)
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                    
                
            }
        }

        }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            Group {
                LogInView()
                    .padding()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .environmentObject(Authentication())
            }
    }
}


