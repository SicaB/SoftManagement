//
//  Background.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 07/06/2021.
//

import SwiftUI

struct BackgroundColor: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("blue"), Color("lightblue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}



struct BackgroundImage: View {
    
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .foregroundColor(Color.blue)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .opacity(0.65)
    }
}

