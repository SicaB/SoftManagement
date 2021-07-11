//
//  ProjectListViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 24/06/2021.
//

import SwiftUI
import Combine

class ProjectListViewModel: ObservableObject {
    
    @EnvironmentObject var appInfo: AppInformation
    @Published var repository = ProjectRepository()
    @Published var projectsInDB = false
    
    
    @Published var allProjects: [Project] = []
    
//    @Published var projects = [String]()
    @Published var projectDocIds = [String]()
    
    let group = DispatchGroup()    
    
    func anyProjectsInDB() {
            self.repository.anyProjectsInDatabase(completion: { (anyProjects) in
                self.projectsInDB = anyProjects
                self.repository.isLoading = false
              
            })
    }
    
    func getProjects() {
            DispatchQueue.main.async { [self] in
            repository.isLoading = true
                    self.repository.getAllProjects(completion: { (projects, docIDs) in
                        self.allProjects.removeAll()
                        self.allProjects.append(contentsOf: projects)
                        //print("hello: content of array: \(self.allProjects)")
                        print("getProject Called")
                        self.projectDocIds.removeAll()
                        self.projectDocIds.append(contentsOf: docIDs)
                       // self.repository.dbHasBeenChecked = true
                        self.repository.isLoading = false
                       

                        //              if self.source.isEmpty {
                        //                  // create the alert
                        //                         let alert = UIAlertController(title: "Intet indtastet!", message: "Du har ikke indtastet noget i dag.", preferredStyle: UIAlertController.Style.alert)
                        //
                        //                         // add an action (button)
                        //                         alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        //
                        //                         // show the alert
                        //                         self.present(alert, animated: true, completion: nil)
                        //
                        //                 return
                        //              }
                    })
        }

    }
    
    func deleteProject(at indexSet: IndexSet) {

        DispatchQueue.main.async { [self] in
            repository.isLoading = true
            indexSet.forEach { index in
                allProjects.remove(at: index)
            }
            repository.deleteProject(at: indexSet, docIds: projectDocIds)
            anyProjectsInDB()
        }
        
       
    }
    
}
