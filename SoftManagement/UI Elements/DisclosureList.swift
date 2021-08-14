//
//  DisclosureList.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/07/2021.
//

import SwiftUI

struct DisclosureList: View {
    @ObservedObject var viewModel: HomeScreenViewModel
    @EnvironmentObject var appInfo: AppInformation
    var team: Team
    
    var body: some View {
  
        ForEach(team.tasks, id: \.self) { task in
            VStack{
                
                Text(task)
                .font(.title3)
                .foregroundColor(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 20, alignment: .leading)
                
            }
            Divider()
            
            
        }

     }

        
    }


struct DisclosureList_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureList(viewModel: HomeScreenViewModel(), team: Team(name: "No Team Selected", docId: "", tasks: [], teamWorkloadInHours: 0, hoursOfDoneWork: 0, workDonePercentage: 0.0))
    }
}
