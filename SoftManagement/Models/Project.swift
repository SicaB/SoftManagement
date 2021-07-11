//
//  Project.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Project: Identifiable, Decodable {
    
    
    var id: String { name }
    var name: String = ""
    var startDate = Date()
    var deadLine = Date()
    var progressCount: Float = 0.0
   // var projectOwner = User()
    var teams = [Team]()
   // var teamMember = ""
    //var task = Task()
    
    init(name: String, teams: [Team]) {
        self.name = name
//        self.startDate = Date()
//        self.deadLine = Date()
        self.teams = teams
        
    }
    
}

//struct ProjectResponse {
//    let request: [Project]
//}

//struct MockData {
//    static let sampleProject = Project(name: "Test Project", teams: [])
//
//    static let projects = [sampleProject, sampleProject,sampleProject,sampleProject]
//}
