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
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack {
                    Form {
                        Section(header: Text("Project Information")) {
                            TextField("Project Name", text: $viewModel.project.name)
                                .disableAutocorrection(true)
                        }
                        Section(header: Text("Dates")) {
                            
                            // Startdate
                            DatePicker(selection: $viewModel.project.startDate, in: Date()..., displayedComponents: .date) {
                                Text("Start Date")
                            }
                            
                            // Deadline
                            DatePicker(selection: $viewModel.project.deadLine, in: Date()..., displayedComponents: .date) {
                                Text("Deadline")
                            }
                            
                            
                        }
                        
                        Section(header: Text("")){
                           // NavigationLink(destination: HomeScreenView()){
                                Button {
                                    if viewModel.project.name.isEmpty {
                                        authentication.alertItem = AlertContext.invalidProjectName
                                    } else {
                                        if viewModel.project.startDate > viewModel.project.deadLine {
                                            authentication.alertItem = AlertContext.invalidTimeline
                                        } else {
                                            viewModel.saveProject(input: viewModel.project)
                                            isPresented.toggle()
                                            self.didAddProject(.init(true))
                                        }
                                    
                                    
                                    }
                                        
                                    } label: {
                                        Text("Done")
                                        
                                    }
                         //   }
                            
                            
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Create Project")
            .background(Color("h2"))
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
            
        }
    }
}

//struct CreateProjectView_Previews: PreviewProvider {
//    var isPresented = true
//    static var previews: some View {
//        CreateProjectView(isPresented: .constant(true), didAddProject)
//            .environmentObject(Authentication())
//    }
//}
