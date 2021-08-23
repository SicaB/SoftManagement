//
//  CreateTaskView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/07/2021.
//

import SwiftUI
import Introspect

struct TeamInfoView: View {
    
    @EnvironmentObject var appInfo: AppInformation
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = TeamInfoViewModel()
    @State private var showingAlert = false
    @State private var showingTaskAlert = false
    
    @State private var days: Int = 0
    @State private var hours: Int = 0
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var isExpanded = false
    @State private var uiTabarController: UITabBarController?
    
    var body: some View {
        ZStack {
            VStack {
                VStack(){

                    Text(appInfo.selectedProject.name)
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding(.top, 40)

                }
                .frame(maxWidth: .infinity, maxHeight: 180)
                .background(Color("darkgray"))
                
                VStack(){
                    HStack{
                        Text(String(viewModel.selectedTeam.name.prefix(2)))
                            .bold()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                            .background(Circle().fill(Color("teamcolor1")))
                        
                        
                        
                        VStack{
                            Text(viewModel.selectedTeam.name)
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.white)
                                .padding(.leading, 8)
                                .padding(.bottom, -4)
                            
                            ProgressBar(value: viewModel.selectedTeam.workDonePercentage)
                                .frame(height: 20)
                                .padding(.horizontal, 8)
                        }
                        
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .frame(alignment: .trailing)
                            .foregroundColor(Color("lightgray"))
                            .onTapGesture {
                                self.showingAlert = true
                                
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(
                                    title: Text("Delete Team")
                                        .bold()
                                        .font(.title2),
                                    message: Text("Are you sure you want to delete the team \(viewModel.selectedTeam.name)?"),
                                    primaryButton: .destructive(Text("Delete")){
                                        viewModel.deleteTeam(userDocId: appInfo.userDocId)
                                        mode.wrappedValue.dismiss()
                                    }, secondaryButton: .cancel()
                                    
                                )
                                
                            }
                    }
                    
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .padding()
                .background(Color("card"))
                .cornerRadius(25)
                .shadow(color: Color("backgroundgray"), radius: 10)
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                ScrollView{
                    Text("Create Task")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .foregroundColor(Color("h1"))
                    
                    VStack(){
                        
                        TaskInformation(viewModel: viewModel)
                        
                        HStack(spacing: 75){
                            Text("Days")
                                .foregroundColor(Color("h1"))
                            Text("Hours")
                                .foregroundColor(Color("h1"))
                        }
                        .padding()
                        
                        
                        GeometryReader { geometry in
                            HStack(alignment: .center) {
                                Spacer()
                                Picker("", selection: $days){
                                    ForEach(0..<31, id: \.self) { i in
                                        Text("\(i)").tag(i)
                                            .foregroundColor(Color.white)
                                    }
                                }
                                .frame(width: geometry.size.width/3, height: 80)
                                .clipped()
                                
                                Picker("", selection: $hours){
                                    ForEach(0..<24, id: \.self) { i in
                                        Text("\(i)").tag(i)
                                            .foregroundColor(Color.white)
                                    }
                                }
                                
                                .frame(width: geometry.size.width/3, height: 80)
                                .clipped()
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 80)

                        Button {
                            viewModel.task.workLoad = viewModel.calculateTaskWorkload(days: days, hours: hours)
                            if viewModel.task.workLoad == 0 || viewModel.task.title.isEmpty {
                                self.showingTaskAlert = true
                            } else {
                                viewModel.saveTask(userDocId: appInfo.userDocId)
                                viewModel.getTasks(userDocId: appInfo.userDocId)

                                days = 0
                                hours = 0
                            }
 
                        } label: {
                            SoftBtn(title: "Create Task", textColor: .white, backgroundColor: Color("teamcolor1"), opacity: 0.8)
                            
                        }
                        .padding(.top, 20)
                        .alert(isPresented: $showingTaskAlert) {
                            Alert(
                                title: Text("Invalid Task Info")
                                    .bold()
                                    .font(.title2),
                                message: Text("Make sure to give your task both a name and a workload!"),
                                dismissButton: .default(Text("OK"))
                                
                            )
                            
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color("card"))
                    .cornerRadius(25)
                    .shadow(color: Color("backgroundgray"), radius: 10)
                    .padding(.horizontal)
                    
                    if viewModel.repository.isLoading {
                        VStack{
                            LoadingView()
                                
                        }
                        .padding()
                        .background(Color("card"))
                        .cornerRadius(25)
                        .shadow(color: Color("backgroundgray"), radius: 10)
                        .padding(.horizontal)
                        .frame(height: 400)
                        .padding(.bottom, 20)
                        
                       
                    } else {
                        TaskList(viewModel: viewModel)
                            
                    }

                }
                
            }
            .preferredColorScheme(.light)
            .introspectTabBarController { (UITabBarController) in
                UITabBarController.tabBar.isHidden = true
                    uiTabarController = UITabBarController
                }
                .onAppear(){
                viewModel.userDocId = appInfo.userDocId
                viewModel.selectedProjectDocId = appInfo.selectedProject.docId
                viewModel.selectedTeam = appInfo.selectedTeam
                viewModel.getTasks(userDocId: appInfo.userDocId)
                print(appInfo.selectedTeam.docId)
                    
        

            }
            .onDisappear(){
                
            }
        }
        .background(Color("backgroundgray"))
        .edgesIgnoringSafeArea(.all)

    }
   
    
}


struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TeamInfoView()
            .environmentObject(AppInformation())
            .environmentObject(Authentication())
    }
}
