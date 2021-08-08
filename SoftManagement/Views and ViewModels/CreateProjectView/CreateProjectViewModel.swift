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
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        
        UINavigationBar.appearance().backgroundColor = .clear
        
 
    }
    
    func saveProject(input: Project){
        repository.saveProject(input: input)
    }
    
    
    
    
}
