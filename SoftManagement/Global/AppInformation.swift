//
//  AppInformation.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 06/07/2021.
//

import SwiftUI
import FirebaseAuth

final class AppInformation: ObservableObject {
   
    @Published var selectedProject = Project(name: "", docId: "", progressCount: 0.0)
    @Published var selectedTab: TabItem.TabItemType = .projects
    @Published var showPlanTab = false
    @Published var showSheetView = false
    @Published var teamInfoViewIsOpen = false
    @Published var activeSheet: ActiveSheet = .none
    @Published var repository = ProjectRepository()
    @Published var userId = ""
    @Published var userDocId = ""
    @Published var selectedTeam = Team(name: "No Team Selected", docId: "", tasks: [], teamWorkloadInHours: 0, hoursOfDoneWork: 0, workDonePercentage: 0.0)
    @Published var teams: [Team] = []
    @Published var teamDocIds = [String]()
    @Published var signedIn = false
    @Published var alertItem : AlertItem?
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    init() {
        repository.isLoading = false
    }
    
    func saveSelectedProject(project: Project) {
        selectedProject = project
        print("From appInformation saveProject: \(selectedProject)")
        self.getTeams(projectDocId: project.docId)
    }
    
    func anyProjectsInDB() {
        repository.getUser(userId: userId) { user in
            self.userDocId = user.docId
            print("From anyProjectsInDB: docId is: \(self.userDocId)")
            self.repository.anyProjectsInDatabase(userDocId: user.docId, completion: { (anyProjects) in
                    self.showPlanTab = anyProjects
                    //self.repository.isLoading = false

                })
        }
        
        
    }
    
    func getUser(){
        repository.getUser(userId: userId) { user in
            self.userDocId = user.docId
           
        }
    }

    func getTeams(projectDocId: String) {
                self.repository.getTeams(userDocId: userDocId, projectDocId: projectDocId, completion: { (team, docIDs) in
                    self.teams.removeAll()
                    self.teams.append(contentsOf: team)
                    print("getTeams Called")
                    self.teamDocIds.removeAll()
                    self.teamDocIds.append(contentsOf: docIDs)
                    self.calculateProjectStatus()
                })
                
            for docId in self.teamDocIds {
                    self.repository.getTasks(userDocId: userDocId, projectDocId: projectDocId, teamDocId: docId, completion: { (task, docIDs) in
                })
            }
    }
    
    func calculateProjectStatus() {
        var allTeamHours: [Int] = []
        var allTeamDoneHours: [Int] = []
        for workload in teams {
            allTeamHours.append(workload.teamWorkloadInHours)
            allTeamDoneHours.append(workload.hoursOfDoneWork)
        }
        let sumOfallTeamHours = allTeamHours.reduce(0, +)
        let sumOfallTeamDoneHours = allTeamDoneHours.reduce(0, +)
        let workDonePercent = Float(sumOfallTeamDoneHours)/Float(sumOfallTeamHours)
        if workDonePercent.isNaN {
            selectedProject.progressCount = 0.0
        } else {
            selectedProject.progressCount = workDonePercent
        }
        
        repository.updateProjectData(userDocId: userDocId, input: selectedProject, projectDocId: selectedProject.docId)
        repository.isLoading = false
    }
    
    struct TabItem: Hashable {
        let imageName: String
        let title: String
        let type: TabItemType
        
        enum TabItemType {
            case plan
            case projects
            case account
        }
    }
    
    enum ActiveSheet: Identifiable {
        case showProjectView, showTeamView, none
        
        var id: Int {
            hashValue
        }
    }
    
}
