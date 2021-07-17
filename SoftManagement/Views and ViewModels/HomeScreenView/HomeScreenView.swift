//
//  FrontPageView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/06/2021.
//

import SwiftUI

struct HomeScreenView: View {

    @StateObject var viewModel = HomeScreenViewModel()
    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        ZStack{
            VStack(){
            ProjectNameOverview()
            ScrollView{
                
                VStack(){

                    TeamsHeadline()
                    
                    ListOfTeamsView(viewModel: viewModel)
                    
//                    if appInfo.selectedProject.teams.isEmpty {
//                        NoTeamsAddedView()
//                    } else {
//                        ProjectTaskOverview(viewModel: viewModel)
//                    }

                   // notificationOverview(viewModel: viewModel)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            }
            .navigationBarHidden(true)
                
    }
        .background(Color("backgroundgray"))
        .onAppear(){
            viewModel.getTeams(projectDocId: appInfo.selectedProject.docId)
        }
}
    
}






struct ListOfTeamsView: View {

    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel: HomeScreenViewModel
    @State private var action: Int? = 0
    @State private var tasksItems = [Task]()
 
    

//    List(MockData.projects) { project in
//            Text(project.name)
//        }
    
    //                List(items, children: \.items) { row in
    
    
    
    var body: some View{
        VStack(){
            NavigationLink(
                destination: CreateTaskView(), tag: 1, selection: $action){
                
            }

            ForEach(viewModel.teams) { team in
                DisclosureGroup(
                    content: {
                            
                       
                            DisclosureList(viewModel: viewModel, team: team)
                            
                        
  
                }, label: {
                        Button(action: {
                            self.appInfo.selectedTeam = team
                            self.action = 1
  
                        }, label: {
                            TeamCard(title: team.name)
                        })
                    }
                )
                .frame(maxWidth: .infinity, minHeight: 60)
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color("shadowgray"), radius: 10)
            }
      
            }
            .padding()
            //.frame(maxWidth: .infinity, minHeight: 330, maxHeight: .infinity)
            //.background(Color.white)
            //.frame(alignment: .top)
            //.cornerRadius(5)
            //.padding(.horizontal, 10)
            //.shadow(color: Color("shadowgray"), radius: 10)
            .onAppear(){
            viewModel.selectedProjectId = appInfo.selectedProject.docId
            viewModel.getTeams(projectDocId: appInfo.selectedProject.docId)
                print("from onappear in taskview: \(viewModel.teams)")
                for team in viewModel.teams  {
                    print("from onappear in taskview: \(team)")
                }
           
            appInfo.teams = viewModel.teams
        }
        
    }
    
}


//struct AddTeamView: View {
//
//    @EnvironmentObject var appInfo: AppInformation
//    @EnvironmentObject var authentication: Authentication
//    @ObservedObject var viewModel: HomeScreenViewModel
//
//    var body: some View {
//
//        Button(action: {
//            appInfo.activeSheet = .showTeamView
//            appInfo.showSheetView.toggle()
//        }, label: {
//            HStack(){
//
//            PlusImage()
//                .padding(5)
//
//            Text("Create New Team")
//                .font(.title2)
//                .bold()
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading, 10)
//                .foregroundColor(Color("lightgray"))
//
//
//
//        }
//         .frame(maxWidth: .infinity, minHeight: 40)
//         .padding()
//         .sheet(isPresented: $appInfo.showSheetView, content: {
//            if appInfo.activeSheet == .showTeamView {
//                CreateTeamView(isPresented: $appInfo.showSheetView, didAddTeam: {
//                    team in
//                    print("hello: team sheet")
//
//                    viewModel.getTeams(projectDocId: appInfo.selectedProject.docId)
//                    appInfo.anyProjectsInDB()
//                    appInfo.teams = viewModel.teams
//
//                })
//                .environmentObject(self.authentication)
//            }
//
//        })
//        .navigationBarHidden(true)
//        })
//
//    }
//}


//struct notificationOverview: View {
//
//    @ObservedObject var viewModel: HomeScreenViewModel
//    @EnvironmentObject var authentication: Authentication
//
//    var body: some View{
//        HStack(){
//            VStack(){
//                Text("Notifications")
//            }
//
//        }.frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
//        .background(Color.white)
//        .cornerRadius(5)
//        .padding(.horizontal, 5)
//        .shadow(color: Color("shadowgray"), radius: 10)
//
//    }
//}



struct HomeScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            HomeScreenView()
                .environmentObject(AppInformation())
                //.preferredColorScheme(.dark)
        }
        
    }
}
