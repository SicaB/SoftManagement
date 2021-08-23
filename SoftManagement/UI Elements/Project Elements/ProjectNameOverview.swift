//
//  ProjectNameOverview.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/07/2021.
//

import SwiftUI

struct ProjectNameOverview: View {
    
    @EnvironmentObject var appInfo: AppInformation
    
    var body: some View {
        VStack(){
            Spacer(minLength: 50)
            Text(appInfo.selectedProject.name)
                .foregroundColor(Color.white)
                .font(.title)

            VStack(){
                HStack(){
                    Text("Project status %")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .font(.title3)
                .padding(.horizontal)
                .padding(.init(top: -2, leading: 10, bottom: -3, trailing: 10))
                .foregroundColor(Color("lightgray"))
               
                    
                ProgressBar(value: appInfo.selectedProject.progressCount)
                    .frame(height: 30)
                    .padding(.horizontal, 15)
                

            }
            .frame(maxWidth: .infinity, minHeight: 90, alignment: .bottom)
            .background(Color("header"))
            .padding(.bottom, 20)
           
             
            
        }
        .frame(maxWidth: .infinity, maxHeight: 240)
        .background(Color("header"))

    }
}

struct ProjectNameOverview_Previews: PreviewProvider {
    static var previews: some View {
        ProjectNameOverview()
            .environmentObject(AppInformation())
    }
}
