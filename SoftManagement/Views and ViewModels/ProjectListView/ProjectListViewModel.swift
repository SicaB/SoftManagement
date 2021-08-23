//
//  ProjectListViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 24/06/2021.
//

import SwiftUI
import Combine

class ProjectListViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()
    @Published var projectsInDB = false
    @Published var lastAddedProject = Project(name: "", docId: "", progressCount: 0.0)
    @Published var userId = ""
    @Published var allProjects: [Project] = []
    @Published var projectDocIds = [String]()
    
    let group = DispatchGroup()
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectedBackgroundView = {
                    let view = UIView()
                    view.backgroundColor = UIColor(named: "backgroundgray")
                    return view
                }()

    }
    
    func anyProjectsInDB(userDocId: String) {
            self.repository.anyProjectsInDatabase(userDocId: userDocId, completion: { (anyProjects) in
                self.projectsInDB = anyProjects
                self.repository.isLoading = false

            })
    }
    
    func getProjects(userDocId: String) {
            repository.isLoading = true
            DispatchQueue.main.async { [self] in
                    repository.getAllProjects(userDocId: userDocId, completion: { (projects, docIDs) in
                        allProjects.removeAll()
                        allProjects.append(contentsOf: projects)
                        print("getProject Called")
                        projectDocIds.removeAll()
                        projectDocIds.append(contentsOf: docIDs)
                        lastAddedProject = self.allProjects[0]
                        print("Last Project added was: \(self.lastAddedProject.name)")
                        repository.isLoading = false
                    })
            }
    }
    
    func deleteProject(docId: String, userDocId: String) {
        repository.isLoading = true
        DispatchQueue.main.async { [self] in
            repository.deleteProject(userDocId: userDocId, docId: docId)
            anyProjectsInDB(userDocId: userDocId)
        }
        
       
    }
    
}

