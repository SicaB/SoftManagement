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
        .navigationViewStyle(StackNavigationViewStyle())
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
        HStack{
            List {
                ForEach(viewModel.allProjects) { name in
                    Button(action: {
                        withAnimation(.default) {
                            self.selectedName = name.name
                            isAnimated.toggle()
                            appInfo.saveSelectedProject(project: name)
                            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600), execute: {
                                appInfo.selectedTab = .plan
                                isAnimated.toggle()
                            })
                            
                            print("Debug: from onTabGesture \(name.name)")
                        }
                    }) {
                        Text(name.name)
                            .font(.title2)
                        
                    }
                    .animation(.spring())
                    .listRowBackground(self.selectedName == name.name && isAnimated ? Color("blue") : Color(.white))
                    
                }
                .onDelete(perform: viewModel.deleteProject(at:))

            }
            .environment(\.defaultMinListRowHeight, 50)
            
        
        }
        .navigationTitle("Projects")
        .navigationBarItems(trailing: Button(action: {
            appInfo.showSheetView.toggle()
                }, label: {
                    Image(systemName: "plus.rectangle.on.folder")
                        .accentColor(Color("blue"))
                        .font(.title2)
                })
        )
        .onAppear(){
            print("hello: Listview")

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
        .sheet(isPresented: $appInfo.showSheetView, content: {
            CreateProjectView(isPresented: $appInfo.showSheetView, didAddProject: {
                project in
                print("hello: listview sheet")
//                viewModel.repository.projectsInDB = true
//                appInfo.showPlanTab = true
                viewModel.getProjects()
                appInfo.anyProjectsInDB()

            })
            .environmentObject(self.authentication)

        })
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
                .foregroundColor(Color("blue"))
                .padding(.bottom, 100)
                
            Image(systemName: "square.stack.3d.up.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("lightgray"))
                .padding(.bottom, 100)
             
            Text("Create a project and get started")
                .foregroundColor(Color("blue"))
                .padding(.bottom, 10)
            
            Button {
                appInfo.showSheetView.toggle()
                } label: {
                    SoftBtn(title: "Create Project", textColor: .white, backgroundColor: Color("blue"), opacity: 0.8)
                    
                }

        }
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
    static var previews: some View {
        NavigationView{
            ProjectListView()
            
        }
    }
}





