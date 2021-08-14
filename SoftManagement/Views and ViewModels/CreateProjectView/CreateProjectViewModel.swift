//
//  CreateProjectViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 25/06/2021.
//

import SwiftUI

final class CreateProjectViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()
    @Published var project = Project(name: "", docId: "", progressCount: 0.0)
    


    
    func saveProject(input: Project, userDocId: String){
        repository.saveProject(input: input, userDocId: userDocId)
    }
    
    
    
    
}
