//
//  AccountView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        ZStack {
            VStack{
                Text("You are signed in")
                    .foregroundColor(Color("h1"))
                    
                Button {
                    authentication.logOut()
                }
                label: {
                    SoftBtn(title: "Sign Out", textColor: .white, backgroundColor: Color("teamcolor1"), opacity: 0.8)
                    
                }.padding()
            }
            
 
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
