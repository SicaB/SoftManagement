//
//  Logo.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 07/06/2021.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        
        VStack(spacing: 5) {
            Text("SOFT")
                .font(.system(size: 75, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Text("Management")
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)
            
        }
        
        
    }
}
