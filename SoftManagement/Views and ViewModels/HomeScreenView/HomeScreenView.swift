//
//  FrontPageView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 16/06/2021.
//

import SwiftUI
import Introspect

struct HomeScreenView: View {
    
    @StateObject var viewModel = HomeScreenViewModel()
    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    
   
    
    
    var body: some View {
        VStack{
                VStack(){
                    
                    ProjectNameOverview()
                    
                    ScrollView{
                        
                        VStack(){
                            
                            TeamsHeadline()
                            
                            ListOfTeamsView(viewModel: viewModel)

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                .navigationBarHidden(true)

        }
        .background(Color("backgroundgray"))
        .ignoresSafeArea(edges: .top)
        .ignoresSafeArea(edges: .bottom)
        
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            

        }
    }
    
}

struct ListOfTeamsView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel: HomeScreenViewModel
    
    @State private var action: Int? = 0
    @State private var tasksItems = [Task]()
    @State var uiTabarController: UITabBarController?
    
    
    //    List(MockData.projects) { project in
    //            Text(project.name)
    //        }
    
    //                List(items, children: \.items) { row in
    
    
    
    var body: some View{
        
        VStack(){
            NavigationLink(
                destination: TeamInfoView(), tag: 1, selection: $action){
                
            }
            
            
            ForEach(appInfo.teams) { team in
                
                DisclosureGroup(
                    content: {
                        
                        Spacer(minLength: 15)
                        Divider()
                        DisclosureList(viewModel: viewModel, team: team)
                        
                    }, label: {
                        Button(action: {
                            self.appInfo.selectedTeam = team
                            self.action = 1
                            appInfo.teamInfoViewIsOpen = true
                            
                        }, label: {
                            if appInfo.repository.isLoading {
                                LoadingView()
                            } else {
                                TeamCard(title: team.name, value: team.workDonePercentage)
                            }
                            
                        })
                    }
                )
                .frame(maxWidth: .infinity, minHeight: 60)
                .padding()
                .background(Color("card"))
                .cornerRadius(25)
                .shadow(color: Color("shadowgray"), radius: 10)
                
            }
            
            AddTeamView(viewModel: viewModel)
            
            
        }
        .introspectTabBarController { (UITabBarController) in
            UITabBarController.tabBar.isHidden = false
                uiTabarController = UITabBarController
        }
        
        .padding()
        .padding(.bottom, 80)
        //.frame(maxWidth: .infinity, minHeight: 330, maxHeight: .infinity)
        //.background(Color.white)
        //.frame(alignment: .top)
        //.cornerRadius(5)
        //.padding(.horizontal, 10)
        //.shadow(color: Color("shadowgray"), radius: 10)
        .onAppear(){
            appInfo.getTeams(projectDocId: appInfo.selectedProject.docId)
            viewModel.selectedProjectId = appInfo.selectedProject.docId
            appInfo.teamInfoViewIsOpen = false
            uiTabarController?.tabBar.isHidden = false
            //viewModel.getTeams(projectDocId: appInfo.selectedProject.docId)
            //print("from onappear in taskview: \(viewModel.teams)")
//            for team in viewModel.teams  {
//                print("from onappear in taskview: \(team)")
//            }
//
//            appInfo.teams = viewModel.teams
        }
       
        
        
    }
    
}

struct Global {
    static var tabBar : UITabBar?
}


struct AddTeamView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    @ObservedObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        
        Button(action: {
            appInfo.activeSheet = .showTeamView
            appInfo.showSheetView.toggle()
        }, label: {
            HStack(){
                
                PlusImage()
                    .padding(5)
                
                Text("Create New Team")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .foregroundColor(Color("lightgray"))
                
                
                
            }
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding()
            .sheet(isPresented: $appInfo.showSheetView, content: {
                if appInfo.activeSheet == .showTeamView {
                    CreateTeamView(isPresented: $appInfo.showSheetView, didAddTeam: {
                        team in
                        print("hello: team sheet")
                        
                        appInfo.getTeams(projectDocId: appInfo.selectedProject.docId)
                        appInfo.anyProjectsInDB()
                       // appInfo.teams = viewModel.teams
                        
                    })
                    .environmentObject(self.authentication)
                }
                
            })
            .navigationBarHidden(true)
        })
        
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            HomeScreenView()
                .environmentObject(AppInformation())
        }
        
    }
}
