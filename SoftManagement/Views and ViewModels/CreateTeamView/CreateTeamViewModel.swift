//
//  CreateTeamViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 11/07/2021.
//

import SwiftUI

class CreateTeamViewModel: ObservableObject {
 
    @Published var repository = ProjectRepository()
    @Published var team = Team(name: "", docId: "", tasks: [])
    
    func saveTeam(input: Team, docId: String) {
        repository.saveTeamToProject(input: input, docId: docId)
    }
}
