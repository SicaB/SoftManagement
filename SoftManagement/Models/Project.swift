//
//  Project.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct Project: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name = ""
    var startDate = "Date()"
    var deadLine = "Date()"
    var projectOwner = "User()"
    var team = ""
    var teamMember = ""
    var task = "Task()"
    
}

struct ProjectResponse {
    let request: [Project]
}

struct MockData {
    static let sampleProject = Project(id: "01", name: "Test Project", startDate: "Date()", deadLine: "Date()", projectOwner: "User()", team: "iOS", teamMember: "Sacha", task: "Task()")
    
    static let projects = [sampleProject, sampleProject,sampleProject]
}
