//
//  ProgressBar.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 21/06/2021.
//

import SwiftUI

struct ProgressBar: View {
    
    var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("blue"))
                    .animation(.linear)
            }
            .cornerRadius(45.0)
            
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.0)
    }
}
