//
//  Task.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct Task: Codable /*, Identifiable*/ {
    var id: String = UUID().uuidString
    var description = ""

    //var teamMember = ""
}

struct TaskMockData {
    static let eksample1 = Task(description: "LogIn page button")
    static let eksample2 = Task(description: "Title text needs to be centeret")
    static let eksample3 = Task(description: "Movie icons color")
    static let eksample4 = Task(description: "home button too small")
}

