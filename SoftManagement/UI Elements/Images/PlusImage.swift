//
//  PlusImage.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/07/2021.
//

import SwiftUI

struct PlusImage: View {
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .frame(alignment: .leading)
            .foregroundColor(Color("lightgray"))
        
    }
}

struct PlusImage_Previews: PreviewProvider {
    static var previews: some View {
        PlusImage()
    }
}
