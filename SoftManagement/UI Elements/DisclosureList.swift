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
            Text(task)
        }
            
            
        
       
          
            
        }

        
    }


struct DisclosureList_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureList(viewModel: HomeScreenViewModel(), team: TeamMockData.sampleTeam1)
    }
}
