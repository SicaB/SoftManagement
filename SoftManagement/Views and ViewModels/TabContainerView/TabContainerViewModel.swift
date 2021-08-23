//
//  TabContainerViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 24/06/2021.
//


import SwiftUI

final class TabContainerViewModel: ObservableObject {
    
   // @Published var repository = ProjectRepository()
    @Published var showPlanTab = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    let tabItemsNoProjects = [AppInformation.TabItem(imageName: "doc.text.magnifyingglass", title: "Projects", type: .projects),
                              .init(imageName: "person", title: "Account", type: .account)
    ]
    let tabItems = [
        AppInformation.TabItem(imageName: "house", title: "Plan", type: .plan),
        .init(imageName: "doc.text.magnifyingglass", title: "Projects", type: .projects),
        .init(imageName: "person", title: "Account", type: .account)
    ]
//    func anyProjectsInDB(userDocId: String) {
//        self.repository.anyProjectsInDatabase(userDocId: userDocId, completion: { (anyProjects) in
//                self.showPlanTab = anyProjects
//            })
//    }
}




