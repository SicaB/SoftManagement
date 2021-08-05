//
//  TabContainerViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 24/06/2021.
//


import SwiftUI

final class TabContainerViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()
    @Published var showPlanTab = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    let tabItemsNoProjects = [AppInformation.TabItem(imageName: "person", title: "Account", type: .account),
                              .init(imageName: "doc.text.magnifyingglass", title: "Projects", type: .projects)
    ]
    
    let tabItems = [
        AppInformation.TabItem(imageName: "house", title: "Plan", type: .plan),
        .init(imageName: "person", title: "Account", type: .account),
        .init(imageName: "doc.text.magnifyingglass", title: "Projects", type: .projects)
    ]
    
    func anyProjectsInDB() {
            self.repository.anyProjectsInDatabase(completion: { (anyProjects) in
                self.showPlanTab = anyProjects
               
            })
    }
    

}




