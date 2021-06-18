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
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor(Color("lightblue"))
     }
    
    var body: some View {
        NavigationView {
            if authentication.signedIn {
                // TODO: Put in right screen...
                AppTabView()

            }
            else {
                LogInScreenView()
                    .navigationBarHidden(true)
            }
        }
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
            
            ZStack() {
                BackgroundColor()
                BackgroundImage(image: "signup")
                
                VStack(alignment: .center) {
                    Spacer().frame(height: 85)
                    
                    Logo()
                    
                    Spacer().frame(height: 140)
                    // Stack to hold textfields and button to login
                    VStack(spacing: 10) {
                        
                        // Email Textfield
                        
                        ZStack (alignment: .leading){
                            if authentication.user.email.isEmpty { Text(usernamePlaceholder).foregroundColor(Color(.white))
                                .padding()
                                .font(.system(size: 18, weight: .semibold, design: .default))
                            }
                            TextField("", text: $authentication.user.email)
                                .padding()
                                .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.white), lineWidth: 2)
                                    
                                    
                                )
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundColor(Color("darkblue"))
                                .keyboardType(.emailAddress)
                                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                .disableAutocorrection(true)
                            
                        }
                        
                        // Secure Textfield
                        ZStack (alignment: .leading){
                            if authentication.user.password.isEmpty { Text(passwordPlaceholder).foregroundColor(Color(.white))
                                .padding()
                                .font(.system(size: 18, weight: .semibold, design: .default))
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
                                .foregroundColor(Color("darkblue"))
   
                        }
                        
                        Button {
                            authentication.forgotPassword(email: authentication.user.email)
                        } label: {
                            Text("Forgot Password?")
                                .accentColor(Color(.systemBlue))
                                .offset(x: 70, y: -5)
                        }
                
                        // Navigation
                        Button {
                            authentication.logIn(userEmail: authentication.user.email, userPassword: authentication.user.password)
                        }
                        label: {
                            SoftBtn(title: "LOG IN", textColor: .white, backgroundColor: Color("blue"), opacity: 0.8)

                        }
                        
                    }
                    
                    // Stack to hold signup option
                    VStack(spacing: 8) {
                        Text("Don't have an account?")
                            .foregroundColor(Color(.systemBlue))
                        NavigationLink(
                            destination: SignUpView(),
                            label: {
                                SoftBtn(title: "SIGN UP", textColor: Color("blue"), backgroundColor: .white, opacity: 0.95)
                                
                            })
                    }.padding(.top, 20)
                    
                    Spacer()
                }
                
                
                
            }
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                
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


