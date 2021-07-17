//
//  TeamsHeadline.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/07/2021.
//

import SwiftUI

struct TeamsHeadline: View {

    var body: some View {
        VStack {
            Text("Teams")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 30)
                .foregroundColor(Color.black)
            
            Text("Tab a team to edit")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
                .padding(.leading, 2)
                .padding(.bottom, 5)

//            Image(systemName: "person.3.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .foregroundColor(Color("lightgray"))
//                .padding(.bottom, 10)

           
                
            Spacer()

        }
        .navigationBarHidden(true)
        .padding(.horizontal)
        .frame(height: 35)
        
        }
    }

struct TeamsHeadline_Previews: PreviewProvider {
    static var previews: some View {
        TeamsHeadline()
    }
}
