//
//  HomeScreenViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 21/06/2021.
//

import SwiftUI

final class HomeScreenViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()
    @Published var teams: [Team] = []
    @Published var tasks: [Task] = []
    @Published var teamDocIds = [String]()
    @Published var taskDocIds = [String]()
    @Published var selectedProjectId = String()
    
    
    
//    func anyTeamsInDB() {
//            self.repository.anyTeamsInDatabase(completion: { (anyTeams) in
//                self.teamsInDB = anyTeams
//                self.repository.isLoading = false
//
//            })
//    }


    
    func deleteTeam(at indexSet: IndexSet) {
        indexSet.forEach { index in
            teams.remove(at: index)
        }
        repository.deleteTeam(at: indexSet, projectDocId: selectedProjectId, teamDocIds: teamDocIds)
    }
    
    func getTeams(projectDocId: String) {
            DispatchQueue.main.async { [self] in
            repository.isLoading = true
                self.repository.getTeams(projectDocId: projectDocId, completion: { (team, docIDs) in

                    self.teams.removeAll()
                        self.teams.append(contentsOf: team)
                    
                        print("getTeams Called")
                        self.teamDocIds.removeAll()
                        self.teamDocIds.append(contentsOf: docIDs)
                
                    
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
                
                for docId in self.teamDocIds {
                    self.repository.getTasks(projectDocId: projectDocId, teamDocId: docId, completion: { (task, docIDs) in
                        
                        
                })
    
            }
        }

    }
    
    
    
    func deleteTask(at indexSet: IndexSet) {
        indexSet.forEach { index in
            teams.remove(at: index)
        }
        repository.deleteTeam(at: indexSet, projectDocId: selectedProjectId, teamDocIds: teamDocIds)
    }
    
    func getTasks(projectDocId: String, teamDocId: String) {
            DispatchQueue.main.async { [self] in
            repository.isLoading = true
                self.repository.getTasks(projectDocId: projectDocId, teamDocId: teamDocId, completion: { (teams, docIDs) in
                        self.tasks.removeAll()
                    self.tasks.append(contentsOf: teams)
                    
                        print("getTasks Called")
                        self.taskDocIds.removeAll()
                        self.taskDocIds.append(contentsOf: docIDs)
                       
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
    
  
    
}



