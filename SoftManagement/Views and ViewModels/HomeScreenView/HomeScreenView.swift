//
//  FrontPageView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/06/2021.
//

import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        ZStack{
            BackgroundColor()
            ScrollView{
                VStack(spacing: 5){
                    
                    projectOverView()
                    
                    projectStatusBar()
                    
                    projectTaskOverview()
                    
                    notificationOverview()
                }
                
                
                
            }.frame(maxWidth: .infinity)
            
        }
            
                
    }
}

struct projectOverView: View {
    var body: some View {
        HStack(){
            
            Text("Project Name")
                .foregroundColor(Color("blue"))
                .font(.title2)
            
        }.frame(maxWidth: .infinity, minHeight: 70, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 15)
        .padding(.top, 10)
    }
}

struct projectStatusBar: View {
    var body: some View {
        HStack(){
            Group {
                Text("statusbar")
            }.frame(maxWidth: .infinity, minHeight: 30, alignment: .center)
            .background(Color("blue"))
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.horizontal, 10)

        }.frame(maxWidth: .infinity, minHeight: 50, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 15)
    }
}

struct projectTaskOverview: View {
    var body: some View{
        HStack(){
            VStack(spacing: 10){
                Text("Team progress")
                
            }.padding(10)
            
        }.frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 15)
    }
}

struct notificationOverview: View {
    var body: some View{
        HStack(){
            VStack(){
                Text("Notifications")
            }
            
        }.frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 15)
    }
}



struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
            HomeScreenView()
    }
}
