//
//  AccountView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

//struct AccountView: View {
//    @EnvironmentObject var authentication: Authentication
//    @StateObject var viewModel = AccountViewModel()
//
//
//    var body: some View {
//        ZStack {
//            if viewModel.signedOut {
//                LogInView()
//            }
//            else {
//                AccountViewScreen(viewModel: viewModel).navigationBarHidden(true)
//            }
//
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color("backgroundgray"))
//        .ignoresSafeArea(edges: .all)
//        .navigationViewStyle(StackNavigationViewStyle())
//        .navigationBarHidden(true)
//
//    }
//}

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
    @EnvironmentObject var appInfo: AppInformation
    var body: some View {
        ZStack {
            VStack{
                Text("You are signed in")
                    .foregroundColor(Color("h1"))
                    
                Button {
                    viewModel.send(action: .logOut)
                }
                label: {
                    SoftBtn(title: "Sign Out", textColor: .white, backgroundColor: Color("teamcolor1"), opacity: 0.8)
                    
                }.padding()
            }
            
 
        }
        .onChange(of: viewModel.signedOut) { newValue in
            appInfo.signedIn = false
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundgray"))
        .ignoresSafeArea(edges: .all)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Group{
                AccountView().environmentObject(Authentication())
            }
           
        }
    }
}
