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
                .padding(.top, 20)
                .foregroundColor(Color("h1"))
            
            Text("Tab a team to edit")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("grayedouttext"))
                .padding(.leading, 2)
                .padding(.bottom, 5)

                
            Spacer()

        }
        .navigationBarHidden(true)
        .padding(.horizontal)
        .frame(height: 60)
        
        }
    }

struct TeamsHeadline_Previews: PreviewProvider {
    static var previews: some View {
        TeamsHeadline()
    }
}
