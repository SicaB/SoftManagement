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
        VStack {
            
            Text("You are signed in")
            Button {
                authentication.logOut()
            }
            label: {
                SoftBtn(title: "Sign Out", textColor: .white, backgroundColor: Color("blue"), opacity: 0.8)
                
            }.padding()
        }
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
