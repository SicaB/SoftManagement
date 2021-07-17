//
//  CreateTaskView.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/07/2021.
//

import SwiftUI

struct CreateTaskView: View {
    
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var appInfo: AppInformation
    @StateObject var viewModel = CreateTaskViewModel()

    @State private var isExpanded = false
    
    var body: some View {
            ZStack() {

                VStack {
                    VStack(){
                        
                        Text(appInfo.selectedProject.name)
                            .foregroundColor(Color.white)
                            .font(.title)
                           
                    }
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .background(Color("darkgray"))
                    //.ignoresSafeArea(edges: .top)
                    
                    
                    Text("Create Team")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundColor(Color.black)

                    VStack(){
                        
                        
                        TeamCard(title: appInfo.selectedTeam.name)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: Color("backgroundgray"), radius: 10)
                    .padding(.horizontal)
                    
                    VStack(){
                        
                        Text("Task Information")
                            .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                            .foregroundColor(Color.gray)
                        
                        TextField("Short title name", text: $viewModel.task.title)
                            .foregroundColor(Color("darkblue"))
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.horizontal, 20)
                            .background(Color(.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("shadowgray"), lineWidth: 2)
                                    .blur(radius: 1)
                            )

                        TextField("Discription of the task", text: $viewModel.task.description)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .padding(.horizontal, 20)
                            .background(Color(.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("shadowgray"), lineWidth: 2)
                                    .blur(radius: 1)
                                    
                            
                            )
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(Color("darkblue"))
                        
                        //                            TextField("Expected workload in hours", text: $viewModel.task.workLoad)
                        

                        Button {

                            viewModel.saveTask(input: viewModel.task, projectDocId: appInfo.selectedProject.docId, teamDocId: appInfo.selectedTeam.docId)

                            
                        } label: {
                            SoftBtn(title: "Create Task", textColor: .white, backgroundColor: Color("blue"), opacity: 0.8)
                                
                            
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(color: Color("backgroundgray"), radius: 10)
                    .padding(.horizontal)
                    

                }
                
                
                
                
            }
            .background(Color("backgroundgray"))
            .alert(item: $authentication.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
            
    }
}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        let finalX = CGFloat(cos(angle.radians - .pi / 2))
        let finalY = CGFloat(sin(angle.radians - .pi / 2))
        return self
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("backgroundgray"), lineWidth: 2)
                    .offset(x: finalX * width * 0.6, y: finalY * width * 0.6)
                    .blur(radius: 1)
                    .mask(RoundedRectangle(cornerRadius: 25))
        )
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
            .environmentObject(AppInformation())
            .environmentObject(Authentication())
    }
}
