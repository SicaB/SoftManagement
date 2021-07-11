//
//  AppInformation.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 06/07/2021.
//

import SwiftUI

class AppInformation: ObservableObject {
   
    @Published var selectedProject = Project(name: "No Project Selected", teams: [])
    @Published var selectedTab: TabItem.TabItemType = .projects
    @Published var showPlanTab = false
    @Published var showSheetView = false
    @Published var repository = ProjectRepository()
    
    func saveSelectedProject(project: Project) {
        selectedProject = project
        print("From appInformation saveProject: \(selectedProject)")
    }
    
    func anyProjectsInDB() {
            self.repository.anyProjectsInDatabase(completion: { (anyProjects) in
                self.showPlanTab = anyProjects
               
            })
    }
    
    struct TabItem: Hashable {
        let imageName: String
        let title: String
        let type: TabItemType
        
        enum TabItemType {
            case plan
            case account
            case projects
        }
    }
    
}
