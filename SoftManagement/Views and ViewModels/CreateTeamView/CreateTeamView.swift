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
                                .foregroundColor(Color("h1"))
                                
                        }
                        
                        Section(header: Text("")){
                            // NavigationLink(destination: HomeScreenView()){
                            Button {
                                if viewModel.team.name.isEmpty{
                                    authentication.alertItem = AlertContext.invalidTeamName
                                } else {
                                    viewModel.saveTeam(input: viewModel.team, docId: appInfo.selectedProject.docId, userDocId: appInfo.userDocId)
                                    
                                    appInfo.showSheetView.toggle()
                                    

                                   
                                    self.didAddTeam(.init(true))
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
            .navigationBarTitle("Create Team")
            .navigationBarItems(trailing: Button(action: {
                appInfo.showSheetView.toggle()
                
                //isPresented.toggle()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .accentColor(Color("teamcolor1"))
                    .font(.title)
            })
            .padding(.top, 20)
        )
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView(isPresented: .constant(true), didAddTeam: {
            project in

        })
        .environmentObject(Authentication())
    }
}
