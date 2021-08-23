//
//  SignUpView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 09/06/2021.
//

import SwiftUI

//struct SignUpView: View {
//
//    @EnvironmentObject var authentication: Authentication
//    @StateObject var viewModel = SignUpViewModel()
//
//
//    var body: some View {
//        ZStack{
//            if viewModel.signedIn || authentication.signedIn{
//                TabContainerView()
//            } else {
//                SignUpViewScreen(viewModel: viewModel)
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//
//        .onAppear() {
//            authentication.signedIn = authentication.isSignedIn
//            print("heeieiilllooo")
//        }
//
//
//    }
//}

struct SignUpView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var viewModel = SignUpViewModel()
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    
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
                                if viewModel.user.name.isEmpty {
                                    Text(viewModel.placeholder[0])
                                        .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $viewModel.user.name)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            VStack{
                                Divider().background(Color("h2"))
                            }
                            
                            ZStack(alignment: .leading){
                                if viewModel.user.username.isEmpty {
                                    Text(viewModel.placeholder[1])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $viewModel.user.username)
                                    .disableAutocorrection(true)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }
                           
                            ZStack(alignment: .leading){
                                if viewModel.user.email.isEmpty {
                                    Text(viewModel.placeholder[2])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                TextField("", text: $viewModel.user.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }

                            ZStack(alignment: .leading){
                                if viewModel.user.password.isEmpty {
                                    Text(viewModel.placeholder[3])
                                            .foregroundColor(Color("grayedouttext"))
                                }
                                SecureField("", text: $viewModel.user.password)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                    .disableAutocorrection(true)
                                    .accentColor(.white)
                            }
                            
                            VStack{
                                Divider().background(Color("h2"))
                            }
                            
                            
                            Button {
                                viewModel.send(action: .signup)
//                                if viewModel.isValidForm {
//                                    mode.wrappedValue.dismiss()
//                                    
//                                }
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
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
                
            }
            .onChange(of: viewModel.signedIn) { newValue in
                appInfo.signedIn = newValue
            }
            .onChange(of: viewModel.userId) { newValue in
                appInfo.userId = newValue
            }
            
        }
        .onChange(of: viewModel.signedIn) { newValue in
            appInfo.signedIn = newValue
        }
        .navigationBarTitle("Sign Up")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundgray"))
        .edgesIgnoringSafeArea(.bottom)
        .edgesIgnoringSafeArea(.top)
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
