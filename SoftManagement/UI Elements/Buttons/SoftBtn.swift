//
//  SoftBtn.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 07/06/2021.
//

import SwiftUI

struct SoftBtn: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    var opacity: Double
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .opacity(opacity)
            .font(.system(size: 18, weight: .semibold, design: .default))
            .cornerRadius(10)
    }
}

struct SoftBtn_Previews: PreviewProvider {
    static var previews: some View {
        SoftBtn(title: "SIGN UP", textColor: Color.white, backgroundColor: Color("blue"), opacity: 0.8)
    }
}
