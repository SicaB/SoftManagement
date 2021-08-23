//
//  TeamCard.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/07/2021.
//

import SwiftUI

struct TeamCard: View {
    
    var title: String
    var value: Float
    
    var body: some View {
        HStack{
            Text(String(title.prefix(2)))
                .bold()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.white)
                .clipShape(Circle())
                .background(Circle().fill(Color("teamcolor1")))
            VStack{
                Text(title)
                    .font(.title3)
                    .foregroundColor(Color("h1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                    .padding(.bottom, -4)
                    
                ProgressBar(value: value)
                    .frame(height: 20)
                    .padding(.horizontal, 8)
            }
        }
    }
}

struct TeamCard_Previews: PreviewProvider {
    static var previews: some View {
        TeamCard(title: "iOS", value: 0.2)
    }
}
