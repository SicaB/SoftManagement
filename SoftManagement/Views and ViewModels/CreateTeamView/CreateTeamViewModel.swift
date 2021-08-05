//
//  CreateTeamViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 11/07/2021.
//

import SwiftUI

class CreateTeamViewModel: ObservableObject {
 
    @Published var repository = ProjectRepository()
    @Published var team = Team(name: "", docId: "", tasks: [], teamWorkloadInHours: 0, hoursOfDoneWork: 0, workDonePercentage: 0.0)
    
    func saveTeam(input: Team, docId: String) {
        repository.saveTeamToProject(input: input, docId: docId)
    }
}
