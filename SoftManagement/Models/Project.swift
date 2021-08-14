//
//  Project.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Project: Identifiable, Codable {
    
    var docId: String = ""
    var id: String { name }
    var name: String = ""
    var startDate = Date()
    var deadLine = Date()
    var progressCount: Float = 0.0

    
    init(name: String, docId: String, progressCount: Float) {
        self.name = name
        self.docId = docId
        self.progressCount = progressCount

    }
    
}


struct MockData {
    static let sampleProject = Project(name: "Test Project", docId: "54646", progressCount: 0.5)

    static let projects = [sampleProject, sampleProject, sampleProject, sampleProject]
}
