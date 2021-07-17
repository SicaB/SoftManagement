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
    var tasks = [String]()
    
    init(name: String, docId: String, tasks: [String]) {
        self.name = name
        self.docId = docId
        self.tasks = tasks
//        self.startDate = Date()
//        self.deadLine = Date()
//        self.teams = teams
        
    }
}



struct TeamResponse {
    let request: [Team]
}

struct TeamMockData {
    static let sampleTeam1 = Team(name: "iOS", docId: "01", tasks: TaskMockData.eks)
    static let sampleTeam2 = Team(name: "Android", docId: "02", tasks: TaskMockData.eks)
    static let sampleTeam3 = Team(name: "Web", docId: "03", tasks: TaskMockData.eks)
    static let sampleTeam4 = Team(name: "Design", docId: "04", tasks: TaskMockData.eks)
    static let sampleTeam5 = Team(name: "Backend", docId: "05", tasks: TaskMockData.eks)

    static let teams = [sampleTeam1, sampleTeam2, sampleTeam3, sampleTeam4, sampleTeam5]

}



//extension Team {
//
//    static let iOS = Team(name: "LogIn page button", icon: "person.crop.circle")
//    static let android = Team(name: "Title text needs to be centeret", icon: "person.crop.circle")
//    static let design = Team(name: "Movie icons color", icon: "person.crop.circle")
//    static let web = Team(name: "home button too small", icon: "person.crop.circle")
//
//    // Eksampels
////    static let exampleTeam1 = Team(name: "iOS", icon: "person.crop.circle", items: [Team.iOS, Team.android, Team.design, Team.web])
////    static let exampleTeam2 = Team(name: "Android", icon: "person.crop.circle", items: [Team.iOS, Team.android, Team.design, Team.web])
////    static let exampleTeam3 = Team(name: "Web", icon: "person.crop.circle", items: [Team.iOS, Team.android, Team.design, Team.web])
////    static let exampleTeam4 = Team(name: "Design", icon: "person.crop.circle", items: [Team.iOS, Team.android, Team.design, Team.web])
////    static let exampleTeam5 = Team(name: "Backend", icon: "person.crop.circle", items: [Team.iOS, Team.android, Team.design, Team.web])
//
//}
//
//extension Team {
//
//    static let iOS = Task(description: "LogIn page button", team: "iOS")
//    static let android = Task(description: "Title text needs to be centeret", team: "Android")
//    static let design = Task(description: "Movie icons color", team: "Design")
//    static let web = Task(description: "home button too small", team: "Web")
//
//    // Eksampels
//    static let exampleTeam1 = Team(name: "iOS", icon: "person.crop.circle", tasks: [Team.iOS, Team.android, Team.design, Team.web])
//    static let exampleTeam2 = Team(name: "iOS", icon: "person.crop.circle", tasks: [Team.iOS, Team.android, Team.design, Team.web])
//    static let exampleTeam3 = Team(name: "Android", icon: "person.crop.circle", tasks: [Team.iOS, Team.android, Team.design, Team.web])
//}
