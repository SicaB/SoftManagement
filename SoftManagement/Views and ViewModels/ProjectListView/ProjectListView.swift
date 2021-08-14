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
    @EnvironmentObject var appInfo: AppInformation
    //   @Environment(\.presentationMode) var presentation
    
//    init() {
//        appInfo.userId = authentication.auth.currentUser!.uid
//    }
    
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
        .preferredColorScheme(.light)
        .ignoresSafeArea(edges: .all)
        .onAppear() {
            print("userDoc is: \(appInfo.userDocId)")
            //viewModel.userId = authentication.auth.currentUser?.uid
            viewModel.repository.getUser(userId: appInfo.userId) { user in
                viewModel.anyProjectsInDB(userDocId: user.docId)
            }
            
            //    viewModel.repository.anyProjectsInDatabase(completion: { (anyProjects) in
            
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
    @State var showingAlert = false
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
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color("teamcolor1"))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        .frame(width: 100, height: 60)
                        .padding(.trailing, 25)

                    })
                }
                .padding(.horizontal, 10)
                
                //.frame(maxWidth: .infinity, maxHeight: 60)
                //.padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: 160, alignment: .bottom)
            .background(Color("header"))
            .padding(.bottom, 20)
            
            
            // ForEach(MockData.projects) { (name) in
            
            //Array(self.viewModel.allProjects.enumerated()), id: \.1.id) { (index, name) in
            
            VStack {
                ScrollView {
                    ForEach(Array(self.viewModel.allProjects.enumerated()), id: \.1.id) { (index, name) in
                        HStack{

                            Button(action: {

                                    self.selectedName = name.name
                                    appInfo.saveSelectedProject(project: name)
                                    appInfo.selectedTab = .plan



                            }) {

                                    VStack{
                                        Text(name.name)
                                            .font(.title2)
                                            .foregroundColor(Color("h1"))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 10)
                                           // .padding(.bottom, -1)

                                        ProgressBar(value: name.progressCount)
                                            .frame(height: 20)
                                            .padding(.leading, 10)
                                    }
                                    .padding(.leading, 10)

                            }


                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .frame(alignment: .trailing)
                                .foregroundColor(Color("lightgray"))
                                .padding()
                                .onTapGesture {
                                    self.showingAlert = true
                                    print("hellooo")
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(
                                        title: Text("Delete Project")
                                            .bold()
                                            .font(.title2),
                                        message: Text("Are you sure you want to delete the project \(name.name)?"),
                                        primaryButton: .destructive(Text("Delete")){
                                            viewModel.allProjects.remove(at: index)
                                            viewModel.deleteProject(docId: name.docId, userDocId: appInfo.userDocId)
                                            //mode.wrappedValue.dismiss()
                                        }, secondaryButton: .cancel()

                                    )

                                }
                            //                            .animation(.spring())
                            //                            .listRowBackground(self.selectedName == name.name && isAnimated ? Color.gray : Color(UIColor.systemGroupedBackground))

                            //                            Button(action: {
                            //
                            //                            }) {
                            //                                VStack{
                            //                                    Image(systemName: "trash")
                            //                                        .resizable()
                            //                                        .aspectRatio(contentMode: .fit)
                            //                                        .frame(width: 20, height: 30)
                            //                                        .foregroundColor(Color(.gray))
                            //
                            //
                            //                                }
                            //                                .frame(width: 50, height: 80)
                            //                                .onTapGesture {
                            //
                            //                                }
                            //
                            //
                            //                            }
                            //
                        }
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color("card"))
                        .cornerRadius(25)
                        .shadow(color: Color("shadowgray"), radius: 10)
                        .padding(.vertical, 10)
                        .padding(.leading, 10)

                    }
                    //.onDelete(perform: viewModel.deleteProject(at:))
                    //.listRowBackground(Color("backgroundgray"))
                    //                    .frame(maxWidth: .infinity, minHeight: 80)
                    //                    .cornerRadius(25)
                    //                    .padding(.vertical, 5)


                }
                .environment(\.defaultMinListRowHeight, 50)
                .padding()
            }
            .background(Color("backgroundgray"))
            .cornerRadius(25)
            .shadow(color: Color("backgroundgray"), radius: 10)
            .padding(.top, -15)
            .padding(.bottom, 60)
            .padding (.trailing, 10)
           
            
            
        }
        .sheet(isPresented: $appInfo.showSheetView, content: {
            if appInfo.activeSheet == .showProjectView {
                CreateProjectView(isPresented: $appInfo.showSheetView, didAddProject: {
                    project in
                    print("hello: listview sheet")
                    //                viewModel.repository.projectsInDB = true
                    //                appInfo.showPlanTab = true
                    viewModel.getProjects(userDocId: appInfo.userDocId)
                    appInfo.anyProjectsInDB()
                })
                .environmentObject(self.authentication)
            }

        })
        .background(Color("backgroundgray"))
        .navigationBarHidden(true)
        .onAppear(){

            viewModel.getProjects(userDocId: appInfo.userDocId)
            print(appInfo.userDocId)

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
            
            appInfo.showPlanTab = false
            print("hello: NoProjects")
            
            
        }
        
        .sheet(isPresented: $appInfo.showSheetView, content: {
            CreateProjectView(isPresented: $appInfo.showSheetView, didAddProject: {
                project in
                
                viewModel.projectsInDB = true
                appInfo.showPlanTab = true
                
                
            })
            .environmentObject(self.authentication)
            .environmentObject(self.appInfo)
            
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
            ListOfProjectsView(viewModel: ProjectListViewModel())
                .environmentObject(AppInformation())
                .environmentObject(Authentication())
        }
    }
}





