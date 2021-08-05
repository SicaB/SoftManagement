//
//  TaskList.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 20/07/2021.
//

import SwiftUI

struct TaskList: View {
    
    @ObservedObject var viewModel: TeamInfoViewModel
    @EnvironmentObject var appInfo: AppInformation
    @State private var madeChangesInTasksList = false
    
    var body: some View {
        HStack {
            VStack{
                Text("Tasks")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .foregroundColor(Color("h1"))
                
                Text("Here you can edit your tasks")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .padding(.horizontal, 15)
                    .foregroundColor(Color("lightgray"))

               
            }
//            if madeChangesInTasksList {
//                Text("SAVE")
//                    .bold()
//                    .frame(maxWidth: 50, alignment: .trailing)
//                    .padding(.horizontal, 35)
//                    .padding(.top, 20)
//                    .foregroundColor(Color.blue)
//                    .onTapGesture {
//                        madeChangesInTasksList = false
//                        viewModel.saveDoneWork()
//
//                        print("Project workload: \(appInfo.selectedProject.progressCount)")
//                    }
//            } else {
//                Text("SAVE")
//                    .frame(maxWidth: 50, alignment: .trailing)
//                    .padding(.horizontal, 35)
//                    .padding(.top, 20)
//                    .foregroundColor(Color.gray)
//
//            }
        }

        VStack{
            List {
                ForEach(Array(self.viewModel.allTasks.enumerated()), id: \.1.id) { (index, task) in
                    
                    HStack{
                        Text(task.title)
                            .foregroundColor(Color("h1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            
                        Text("\(task.workLoad) t.")
                            .foregroundColor(Color("h2"))
                            .frame(maxWidth: 50, alignment: .trailing)
                            .padding(.trailing, 4)
                            
                         
 
                        
                        if task.isDone {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .trailing)
                                .foregroundColor(Color("checkgreen"))
                                .onTapGesture {
                                    madeChangesInTasksList = true
                                    viewModel.allTasks[index].isDone = false
                                    viewModel.calculateWorkload()
                                    viewModel.saveDoneWork()
                                }
                            } else {
                                Image(systemName: "circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .trailing)
                                    .foregroundColor(Color("grayedouttext"))
                                    .onTapGesture {
                                        madeChangesInTasksList = true
                                        viewModel.allTasks[index].isDone = true
                                        viewModel.calculateWorkload()
                                        viewModel.saveDoneWork()
                                        
                                    }
                                
                            }
                            
                        
                        
                    }

                }
                .onDelete(perform: viewModel.deleteTask(at:))
                .listRowBackground(Color("card"))
            }
            
            
        }
        .padding()
        .background(Color("card"))
        .cornerRadius(25)
        .shadow(color: Color("backgroundgray"), radius: 10)
        .padding(.horizontal)
        .frame(height: 400)
        .padding(.bottom, 20)

    }
}

struct taskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList(viewModel: TeamInfoViewModel())
    }
}
