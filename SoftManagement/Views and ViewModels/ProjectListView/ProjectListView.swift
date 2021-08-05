//
//  ProjectListView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct ProjectListView: View {
    
    @StateObject var viewModel = ProjectListViewModel()
    @EnvironmentObject var authentication: Authentication
    // @EnvironmentObject var appInfo: AppInformation
    //   @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack{
            if viewModel.repository.isLoading {
                LoadingView()
            }
            else if !viewModel.projectsInDB && !viewModel.repository.isLoading {
                // NO Projects View
                NoProjectsView(viewModel: viewModel)
                // self.appInfo.showPlanTabBarItem = false
                
            }
            else if viewModel.projectsInDB && !viewModel.repository.isLoading {
                // ListView
                ListOfProjectsView(viewModel: viewModel)
                // self.appInfo.showPlanTabBarItem = true
                
            }
        }
        .onAppear() {
            //    viewModel.repository.anyProjectsInDatabase(completion: { (anyProjects) in
            viewModel.anyProjectsInDB()
            print("Hello: from headview")
            //})
            
        }
        //        .onChange(of: appInfo.showPlanTab) { newValue in
        //            viewModel.getProjects()
        //        }
        
    }
}

struct ListOfProjectsView: View {
    
    @ObservedObject var viewModel: ProjectListViewModel
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    @State var isAnimated: Bool = false
    @State private var selectedName: String?
    
    var body: some View {
        VStack {
            VStack {
                HStack() {
                    Text("Projects")
                        .bold()
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        
                   
                    Button(action: {
                        appInfo.activeSheet = .showProjectView
                        appInfo.showSheetView.toggle()
                    }, label: {
                        VStack{
                            Image(systemName: "plus.rectangle.on.folder")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 35)
                                .foregroundColor(Color("teamcolor1"))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .frame(width: 100, height: 60)
                        .padding(.trailing, 25)
                        .sheet(isPresented: $appInfo.showSheetView, content: {
                            if appInfo.activeSheet == .showProjectView {
                                CreateProjectView(isPresented: $appInfo.showSheetView, didAddProject: {
                                    project in
                                    print("hello: listview sheet")
                                    //                viewModel.repository.projectsInDB = true
                                    //                appInfo.showPlanTab = true
                                    viewModel.getProjects()
                                    appInfo.anyProjectsInDB()
                                })
                                .environmentObject(self.authentication)
                            }
                            
                        })
                    })
                }
                
                //.frame(maxWidth: .infinity, maxHeight: 60)
                //.padding()
                
                



            }
            .frame(maxWidth: .infinity, maxHeight: 160, alignment: .bottom)
            .background(Color("header"))
            .ignoresSafeArea(edges: .top)
            
            
            VStack {
                List {
                    ForEach(viewModel.allProjects) { name in
                        
                        HStack{
                            Button(action: {
                                withAnimation(.default) {
                                    self.selectedName = name.name
                                    isAnimated.toggle()
                                    appInfo.saveSelectedProject(project: name)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400), execute: {
                                        appInfo.selectedTab = .plan
                                        isAnimated.toggle()
                                    })
                                }
                            }) {
                                Text(name.name)
                                    .font(.title2)
                                    .foregroundColor(Color("h1"))
                                
                            }
                            .animation(.spring())
                            .listRowBackground(self.selectedName == name.name && isAnimated ? Color("blue") : Color(.white))
                        }
                        
                    }
                    .onDelete(perform: viewModel.deleteProject(at:))
                    .listRowBackground(Color("card"))
                    
                    
                }
                .environment(\.defaultMinListRowHeight, 50)
                .padding()
            }
            .background(Color("card"))
            .cornerRadius(25)
            .shadow(color: Color("backgroundgray"), radius: 10)
            .padding()
            .padding(.top, -50)
            
            
            
            
        }
        .background(Color("backgroundgray"))
        .navigationBarHidden(true)
        
        
        //        .navigationBarItems(trailing: Button(action: {
        //            appInfo.activeSheet = .showProjectView
        //            appInfo.showSheetView.toggle()
        //        }, label: {
        //                    Image(systemName: "plus.rectangle.on.folder")
        //                        .accentColor(Color("teamcolor1"))
        //                        .font(.title2)
        //        })
        //        .padding(.top, 20)
        //        )
        
        .onAppear(){
            
            //            DispatchQueue.main.async { [self] in
            viewModel.getProjects()
            //                appInfo.showPlanTab = true
            ////
            //            }
            
            
            //                print("hello: Listview")
            //
            //                print("Debug: from onAppear in listview \(viewModel.repository.projectsInDB)")
            //
            //
            //            })
            
            ////            viewModel.repository.anyProjectsInDatabase(completion: { (anyProjects) in
            ////                appInfo.showPlanTabBarItem = anyProjects
            //                print("Debug: Calling from onAppear in ListOfProjectsView")
            // //               viewModel.getProjects()
            // //           })
            //
        }
        
        .alert(item: $authentication.alertItem) { alertItem in
            Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
        }
    }
}

struct NoProjectsView: View {
    
    @ObservedObject var viewModel: ProjectListViewModel
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    
    var body: some View {
        VStack {
            Text("No Projects has been created")
                .font(.title2)
                .bold()
                .foregroundColor(Color("h1"))
                .padding(.bottom, 100)
            
            Image(systemName: "square.stack.3d.up.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("lightgray"))
                .padding(.bottom, 100)
            
            Text("Create a project and get started")
                .foregroundColor(Color("h2"))
                .padding(.bottom, 10)
            
            Button {
                appInfo.showSheetView.toggle()
            } label: {
                SoftBtn(title: "Create Project", textColor: .white, backgroundColor: Color("teamcolor1"), opacity: 0.8)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("backgroundgray"))
        .ignoresSafeArea(edges: .top)
        .onAppear(){
            //viewModel.anyProjectsInDB()
            //
            appInfo.showPlanTab = false
            print("hello: NoProjects")
            
            
        }
        
        .sheet(isPresented: $appInfo.showSheetView, content: {
            CreateProjectView(isPresented: $appInfo.showSheetView, didAddProject: {
                project in
                
                print("hello: No project sheet")
                viewModel.projectsInDB = true
                appInfo.showPlanTab = true
                
                //                appInfo.showPlanTab = true
                //                print("Debug: Calling getProjects from .sheet in NoProjectsView")
                // viewModel.getProjects()
                //appInfo.showPlanTab = true
                //                print("Debug: (No ProjectsView) Der er tilføjet et projekt og variablen er derfor: \(viewModel.repository.projectsInDB)")
                
                
            })
            .environmentObject(self.authentication)
            
        })
        .navigationBarHidden(true)
    }
}




struct ProjectListView_Previews: PreviewProvider {
    @ObservedObject var viewModel = ProjectListViewModel()
    init() {
        self.viewModel.repository.isLoading = false
    }
    static var previews: some View {
        NavigationView{
            NoProjectsView(viewModel: ProjectListViewModel())
                .environmentObject(AppInformation())
        }
    }
}





