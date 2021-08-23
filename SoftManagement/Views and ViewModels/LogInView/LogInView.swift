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
    @State private var alertItem: AlertItem?
    @EnvironmentObject var appInfo: AppInformation
    
    var body: some View {
        ZStack {
            if appInfo.signedIn {
                TabContainerView()

            }
            else {
                LogInScreenView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            appInfo.signedIn = appInfo.isSignedIn
            print("heeieiilllooo")
        }
        .onChange(of: viewModel.signedIn) { newValue in
            appInfo.signedIn = newValue
        }
    }
}

struct LogInScreenView: View {
    
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel = LogInViewModel()
    @EnvironmentObject var appInfo: AppInformation
    
    var body: some View {
        NavigationView{
            ZStack() {
                //Background
                BackgroundImage(image: "signup")
                
                VStack(alignment: .center) {
                    Spacer().frame(height: 85)
       
                    Logo()
                    
                    Spacer().frame(height: 140)
                    // Stack to hold textfields and button to login
                    VStack(spacing: 10) {
                        
                        // Email Textfield
                        
                        ZStack (alignment: .leading){
                            if viewModel.user.email.isEmpty { Text(viewModel.usernamePlaceholder)
                                .foregroundColor(Color("lightgray"))
                                .padding()
                                .font(.system(size: 18, weight: .medium, design: .default))
                            }
                            TextField("", text: $viewModel.user.email)
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
                            if viewModel.user.password.isEmpty { Text(viewModel.passwordPlaceholder)
                                .foregroundColor(Color("lightgray"))
                                .padding()
                                .font(.system(size: 18, weight: .medium, design: .default))
                            }
                            SecureField("", text: $viewModel.user.password)
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
                            viewModel.send(action: .forgotPassword)
//                            authentication.forgotPassword(email: authentication.user.email)
                        } label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color("teamcolor1"))
                                .offset(x: 70, y: -5)
                        }
                
                        // Navigation
                        Button {
                            viewModel.send(action: .login)
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
                            destination: SignUpView(),
                            label: {
                                SoftBtn(title: "SIGN UP", textColor: Color("teamcolor1"), backgroundColor: .white, opacity: 0.95)
                                
                            })
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .onChange(of: viewModel.signedIn) { newValue in
                appInfo.signedIn = newValue
            }
            .onChange(of: viewModel.userId) { newValue in
                appInfo.userId = newValue
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("backgroundgray"))
            .ignoresSafeArea(edges: .all)
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                    
                
            }
        }
        .accentColor(Color("teamcolor1"))

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


