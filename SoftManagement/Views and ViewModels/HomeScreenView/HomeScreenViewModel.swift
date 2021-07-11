//
//  HomeScreenViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 21/06/2021.
//

import SwiftUI

final class HomeScreenViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()

    
//    func anyTeamsInDB() {
//            self.repository.anyTeamsInDatabase(completion: { (anyTeams) in
//                self.teamsInDB = anyTeams
//                self.repository.isLoading = false
//
//            })
//    }

    func saveTeamToProject(input: Team, docId: String) {
        repository.saveTeamToProject(input: input, docId: docId)
    }
    
    func deleteTeam(projectDocId: String, teamDocId: [String], team: Team) {
        repository.deleteTeam(projectDocId: projectDocId, teamDocId: teamDocId, team: team)
    }
  
    
}



