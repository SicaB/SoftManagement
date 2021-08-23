//
//  Team.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 18/06/2021.
//

import SwiftUI

struct Team: Codable, Identifiable, Hashable{
    
    var id: String { name }
    var docId: String = ""
    var name: String = ""
    var teamWorkloadInHours: Int = 0
    var hoursOfDoneWork: Int = 0
    var workDonePercentage: Float = 0.0
    var tasks = [String]()
    
    init(name: String, docId: String, tasks: [String], teamWorkloadInHours: Int, hoursOfDoneWork: Int, workDonePercentage: Float) {
        self.name = name
        self.docId = docId
        self.teamWorkloadInHours = teamWorkloadInHours
        self.hoursOfDoneWork = hoursOfDoneWork
        self.workDonePercentage = workDonePercentage
        self.tasks = tasks

    }
}

struct TeamMockData {
    static let eksample1 = "iOS"
    static let eksample2 = "Android"
    static let eksample3 = "Design"
    static let eksample4 = "Web"

    static let eks = [eksample1, eksample2, eksample3, eksample4]

}


