//
//  taskInformation.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 20/07/2021.
//

import SwiftUI

struct TaskInformation: View {
    
    @ObservedObject var viewModel: TeamInfoViewModel
    var taskTitlePlaceholder = "Short Title Name"
    
    var body: some View {
        Text("TASK INFORMATION")
            .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
            .foregroundColor(Color("h2"))
            .padding(.bottom, 10)
        
        ZStack (alignment: .leading){
        if viewModel.task.title.isEmpty {
            Text(taskTitlePlaceholder)
                    .foregroundColor(Color("grayedouttext"))
                    .padding(.horizontal, 25)
                    .font(.system(size: 18, weight: .semibold, design: .default))
        }
        
        TextField("", text: $viewModel.task.title)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, minHeight: 45)
            .font(.system(size: 18, weight: .medium, design: .default))
            .padding(.bottom, 5)
            .foregroundColor(Color(.white))
            
        }
        .background(Color("textfield"))
        
//        TextField("Discription of the task", text: $viewModel.task.description)
//            .frame(maxWidth: .infinity, minHeight: 45)
//            .padding(.horizontal, 20)
//            .background(Color(.white))
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color("shadowgray"), lineWidth: 2)
//                    .blur(radius: 1)
//
//            )
//            .font(.system(size: 18, weight: .medium, design: .default))
//            .foregroundColor(Color("darkblue"))
        
        
        
    }
}

struct taskInformation_Previews: PreviewProvider {
    static var previews: some View {
        TaskInformation(viewModel: TeamInfoViewModel())
    }
}
