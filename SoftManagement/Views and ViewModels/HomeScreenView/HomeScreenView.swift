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
    
    
    var body: some View {
        ZStack{
            //BackgroundColor()
            ScrollView{
                
                VStack(spacing: 4){
                    
                    ProjectNameView(viewModel: viewModel)
                    
                    StatusBarView(viewModel: viewModel)
                    
                    AddTeamView(viewModel: viewModel)
                    
                    ListOfTeamsView(viewModel: viewModel)
                    
//                    if appInfo.selectedProject.teams.isEmpty {
//                        NoTeamsAddedView()
//                    } else {
//                        ProjectTaskOverview(viewModel: viewModel)
//                    }

                    notificationOverview(viewModel: viewModel)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .navigationBarHidden(true)
                
    }
}
    
}


struct ProjectNameView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        HStack(){
            Text(appInfo.selectedProject.name)
                .foregroundColor(Color.white)
                .font(.title)
              
            
        }.frame(maxWidth: .infinity, minHeight: 120, alignment: .center)
        .background(Color("darkgray"))
      //  .cornerRadius(5)
        //.padding(.horizontal, 15)
        .padding(.top, 10)
        .padding(.bottom, -4)
      //  .shadow(radius: 10)


    }
}

struct StatusBarView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        VStack(){
            HStack(){
                Text("Done %")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Planned %")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .font(.footnote)
            .padding(.horizontal)
            .padding(.init(top: -2, leading: 10, bottom: -3, trailing: 10))
            .foregroundColor(Color("blue"))
           
                
            ProgressBar(value: appInfo.selectedProject.progressCount)
                .frame(height: 30)
                .padding(.horizontal, 15)

        }.frame(maxWidth: .infinity, minHeight: 90, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 5)
        //.shadow(radius: 5)
        .shadow(color: Color("shadowgray"), radius: 10)
        
    }
}

struct AddTeamView: View {
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        
    HStack(){
        
        Text("Teams")
            .font(.title2)
            .bold()
            .padding(.top, 15)
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
        
        Image(systemName: "plus.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .trailing)
            .foregroundColor(Color("blue"))
            .onTapGesture {
               
            }
            
            
            
    }
//    .sheet(isPresented: $viewModel.showSheetView, content: {
//        CreateProjectView(isPresented: $viewModel.showSheetView, didAddProject: {
//            project in
//            print("hello: listview sheet")
////                viewModel.repository.projectsInDB = true
////                appInfo.showPlanTab = true
//            viewModel.getProjects()
//            appInfo.anyProjectsInDB()
//
//        })
        
    }
}
    
struct NoTeamsAddedView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    var body: some View {
        VStack {
                
            Image(systemName: "person.3.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("lightgray"))
                .padding(.bottom, 10)
           
            
            Button {
                    // add action
                } label: {
                    SoftBtn(title: "Create Team", textColor: .white, backgroundColor: Color("blue"), opacity: 0.8)
                        
                }
            Spacer()

        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 5)
        .shadow(color: Color("shadowgray"), radius: 10)
        }
    }

struct ListOfTeamsView: View {

    @EnvironmentObject var appInfo: AppInformation
    @ObservedObject var viewModel: HomeScreenViewModel
    @State private var isExpanded = false
    
    let childItems = [TeamMockData.teams]
//    let titles = [TaskMockData.eksample1.team, TaskMockData.eksample2.team, TaskMockData.eksample3.team, TaskMockData.eksample4.team]
    
    var projects: [Project] = []
    
//    var items: [Team] = [.exampleTeam1, .exampleTeam2, .exampleTeam3, .exampleTeam4, .exampleTeam5]
//    List(MockData.projects) { project in
//            Text(project.name)
//        }
    
    //                List(items, children: \.items) { row in
    
    
    
    var body: some View{
        VStack(){
//                Image(systemName: "person.3.fill")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 50, height: 30)
//                    .padding(.leading, 5)
//                    .foregroundColor(Color("lightgray"))
               


                
                List {
                    ForEach(appInfo.selectedProject.teams) { team in
                        Button(action: {
//                        Image(systemName: row.icon)
//                            .resizable()
//                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
//                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .cornerRadius(8)
//                            .foregroundColor(.gray)
//                        VStack(alignment: .leading){
                        }) {
                            
                        Text(team.name)
                            .font(.title2)
                            
//                        ProgressBar(value: 0.1)
//                            .frame(height: 20)
//                            .padding(.horizontal, 15)
                        }
                    }
                }
                .environment(\.defaultMinListRowHeight, 80)
                
              
            }
            .frame(maxWidth: .infinity, minHeight: 330, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal, 5)
            .shadow(color: Color("shadowgray"), radius: 10)
        
    }
    
}


struct notificationOverview: View {
    
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View{
        HStack(){
            VStack(){
                Text("Notifications")
            }
            
        }.frame(maxWidth: .infinity, minHeight: 300, alignment: .center)
        .background(Color.white)
        .cornerRadius(5)
        .padding(.horizontal, 5)
        .shadow(color: Color("shadowgray"), radius: 10)
        
    }
}






struct HomeScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{

//            projectOverView(viewModel: HomeScreenViewModel())
//                .environmentObject(AppInformation())
//            ProjectStatusBar(viewModel: HomeScreenViewModel())
//                .environmentObject(AppInformation())
//            ListOfTeamsView(viewModel: HomeScreenViewModel())
//                .environmentObject(AppInformation())
            AddTeamView(viewModel: HomeScreenViewModel())
                .environmentObject(AppInformation())
            NoTeamsAddedView()
                .environmentObject(AppInformation())
//            HomeScreenView()
//                .environmentObject(AppInformation())
                //.preferredColorScheme(.dark)
        }
        
    }
}
