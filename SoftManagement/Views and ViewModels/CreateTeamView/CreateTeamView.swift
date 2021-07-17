//
//  CreateTeamView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 11/07/2021.
//

import SwiftUI

struct CreateTeamView: View {
    
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    @StateObject var viewModel = CreateTeamViewModel()
    @Binding var isPresented: Bool
    
    var didAddTeam: (Bool) -> ()
    
    var body: some View {
        NavigationView {
            ZStack() {
                VStack {
                    Form {
                        Section(header: Text("Team Information")) {
                            
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 30)
                                .padding()
                                .foregroundColor(Color("lightgray"))
                            
                            TextField("Team Name", text: $viewModel.team.name)
                                
                        }
                        
                        Section(header: Text("")){
                            // NavigationLink(destination: HomeScreenView()){
                            Button {
                                    
                                viewModel.saveTeam(input: viewModel.team, docId: appInfo.selectedProject.docId)

                                isPresented.toggle()
                                self.didAddTeam(.init(true))
                                
                                
                            } label: {
                                Text("Done")
                                
                            }
                            //   }
                            
                            
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Create Team")
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
            
        }
    }
}

//struct CreateTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateTeamView()
//    }
//}
