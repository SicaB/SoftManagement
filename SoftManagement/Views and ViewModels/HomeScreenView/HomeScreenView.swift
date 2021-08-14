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
                    
                    ProjectNameOverview().environmentObject(self.authentication)
                    
                    ScrollView{
                        
                        VStack(){
                            
                            TeamsHeadline().environmentObject(self.authentication)
                            
                            ListOfTeamsView(viewModel: viewModel).environmentObject(self.authentication)

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                }
                .navigationBarHidden(true)

        }
        .background(Color("backgroundgray"))
        .ignoresSafeArea(edges: .all)
        
        
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
    
    var body: some View{
        
        VStack(){
            NavigationLink(
                destination: TeamInfoView().environmentObject(self.authentication), tag: 1, selection: $action){
                
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
        .sheet(isPresented: $appInfo.showSheetView, content: {
            if appInfo.activeSheet == .showTeamView {
                CreateTeamView(isPresented: $appInfo.showSheetView, didAddTeam: {
                    team in
                    print("hello: team sheet")
                    
                    appInfo.getTeams(projectDocId: appInfo.selectedProject.docId)
                    appInfo.anyProjectsInDB()
                    
                })
                .environmentObject(self.authentication)
            }
            
        })
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .padding()
        .padding(.bottom, 80)
        .onAppear(){
            appInfo.getTeams(projectDocId: appInfo.selectedProject.docId)
            viewModel.selectedProjectId = appInfo.selectedProject.docId
            appInfo.teamInfoViewIsOpen = false
            uiTabarController?.tabBar.isHidden = false

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
