//
//  Task.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//
import Foundation

struct Task: Codable, Hashable, Identifiable {
    let id: String
    var docId: String
    var title: String
    var description: String
    var workLoad: Int
    var isDone: Bool
    
    init(id: UUID = UUID(), docId: String, title: String, description: String, workLoad: Int, isDone: Bool) {
        self.id = id.uuidString
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

