//
//  Task.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct Task: Codable, Hashable, Identifiable {
    var id = UUID().uuidString
    var docId: String = ""
    var title: String = ""
    var description = ""
    var workLoad = 0
    var isDone = false
    
    init(docId: String, title: String, description: String, workLoad: Int, isDone: Bool) {
        self.docId = docId
        self.title = title
        self.description = description
        self.workLoad = workLoad
        self.isDone = isDone

    }
}

struct TaskMockData {
    static let eksample1 = "LogIn page button"
    static let eksample2 = "Title text needs to be centeret"
    static let eksample3 = "Movie icons color"
    static let eksample4 = "home button too small"
    
    static let eks = [eksample1, eksample2, eksample3, eksample4]
    
}

