//
//  AppTabView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            HomeScreenView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            
            ProjectListView()
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Projects")
                }
            
        }.accentColor(Color("blue"))
        .navigationBarTitle("OverView", displayMode: .inline)
        
        
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AppTabView()
        }
       
    }
}
