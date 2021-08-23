//
//  CreateNewProjectView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 25/06/2021.
//

import SwiftUI

struct CreateProjectView: View {
    
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    @StateObject var viewModel = CreateProjectViewModel()
    @Binding var isPresented: Bool
    
    var didAddProject: (Bool) -> ()
    

    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack {
                    Form {
                        Section(header: Text("Project Information")) {
                            TextField("Project Name", text: $viewModel.project.name)
                                .disableAutocorrection(true)
                                .accentColor(Color("h1"))
                        }
                        Section(header: Text("Dates")) {
                            
                            // Startdate
                            DatePicker(selection: $viewModel.project.startDate, in: Date()..., displayedComponents: .date) {
                                Text("Start Date")
                                    .foregroundColor(Color("h1"))
                            }
                            .accentColor(Color("teamcolor1"))
                            
                            // Deadline
                            DatePicker(selection: $viewModel.project.deadLine, in: Date()..., displayedComponents: .date) {
                                Text("Deadline")
                                    .foregroundColor(Color("h1"))
                            }
                            .accentColor(Color("teamcolor1"))
                            
                            
                            
                        }
                        
                        Section(header: Text("")){
                           // NavigationLink(destination: HomeScreenView()){
                                Button {
                                    if viewModel.project.name.isEmpty {
                                        appInfo.alertItem = AlertContext.invalidProjectName
                                    } else {
                                        if viewModel.project.startDate > viewModel.project.deadLine {
                                            appInfo.alertItem = AlertContext.invalidTimeline
                                        } else {
                                            viewModel.saveProject(input: viewModel.project, userDocId: appInfo.userDocId)
                                            
                                            appInfo.showSheetView.toggle()
                                            self.didAddProject(.init(true))
                                        }
                                    
                                    
                                    }
                                        
                                    } label: {
                                        Text("Done")
                                            .foregroundColor(Color("teamcolor1"))
                                        
                                    }
                         //   }
                            
                            
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Create Project")
            .navigationBarItems(trailing: Button(action: {
                appInfo.showSheetView.toggle()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .accentColor(Color("teamcolor1"))
                    .font(.title)
            })
            .padding(.top, 20)
            
            )
            .alert(item: $appInfo.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
            
        }
        .preferredColorScheme(.dark)

    }
}

struct CreateProjectView_Previews: PreviewProvider {
    var isPresented = true
    static var previews: some View {
        CreateProjectView(isPresented: .constant(true), didAddProject: {
                          project in
 
                      })
            .environmentObject(Authentication())
            
    }
}
