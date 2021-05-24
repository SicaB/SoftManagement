//
//  ContentView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 18/05/2021.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("blue"), Color("lightblue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ZStack {
                Image("signup")
                    .resizable()
                    .foregroundColor(Color.blue)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0.65)
                
                VStack {
                    Text("SOFT")
                        .font(.system(size: 75, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 140.0)
                    Text("Management")
                        .font(.system(size: 32, weight: .medium, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 10.0)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("SIGN UP")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("blue")/*@END_MENU_TOKEN@*/.opacity(0.8))
                    }
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("LOG IN")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                            .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("blue")/*@END_MENU_TOKEN@*/.opacity(0.8))
                    }
                    
                    }
                    
                    Spacer()
                    
                        
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
            .padding()
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
    }
}
