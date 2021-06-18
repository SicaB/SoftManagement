//
//  ManageProjectView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct ProjectListView: View {
    var body: some View {
        ZStack{
            BackgroundColor()
                List(MockData.projects) { project in
                    Text(project.name)
                        
                    
                }.navigationBarTitle(Text("Account"), displayMode: .inline)
                
                

        }.background(Color(.red))
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProjectListView()
        }
    }
}
