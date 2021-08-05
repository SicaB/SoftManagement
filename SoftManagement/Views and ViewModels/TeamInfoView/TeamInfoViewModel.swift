//
//  CreateTaskViewModel.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/07/2021.
//

import SwiftUI

class TeamInfoViewModel: ObservableObject {
    
    @Published var repository = ProjectRepository()
    @Published var task = Task(docId: "", title: "", description: "", workLoad: 0, isDone: false)
    @Published var allTasks: [Task] = []
    @Published var selectedTeam = Team(name: "", docId: "", tasks: [], teamWorkloadInHours: 0, hoursOfDoneWork: 0, workDonePercentage: 0.0)
    {
        didSet {
            print("Selected teams total workload is now: \(self.selectedTeam.teamWorkloadInHours)")
        }
    }
    @Published var taskDocIds = [String]()
    
    @Published var selectedProjectDocId = ""
    
    let group = DispatchGroup()
    
    init() {
        repository.isLoading = false
        UITableView.appearance().backgroundColor = .clear
    
        
    }

    
    func saveTask() {

        repository.saveTask(input: task, teamDocId: selectedTeam.docId, projectDocId: selectedProjectDocId)

        self.selectedTeam.tasks.append(task.title)
        self.allTasks.append(task)
        self.selectedTeam.teamWorkloadInHours = self.selectedTeam.teamWorkloadInHours + task.workLoad
        self.selectedTeam.workDonePercentage = Float(selectedTeam.hoursOfDoneWork)/Float(self.selectedTeam.teamWorkloadInHours)
        
        task.title = ""
        task.description = ""
        task.workLoad = 0
        
        self.calculateWorkload()
        
        
    }
    
    func deleteTeam() {
        repository.deleteTeam(projectDocId: selectedProjectDocId, teamDocId: selectedTeam.docId)
    }
    
    func deleteTask(at indexSet: IndexSet) {
        repository.isLoading = true
        
                indexSet.forEach { index in
                    let task = allTasks[index]
                    
                    selectedTeam.tasks.remove(at: index)
                    
                    self.selectedTeam.teamWorkloadInHours = self.selectedTeam.teamWorkloadInHours - task.workLoad
                    if task.isDone {
                        selectedTeam.hoursOfDoneWork = selectedTeam.hoursOfDoneWork - task.workLoad
                    }
                    self.selectedTeam.workDonePercentage = Float(selectedTeam.hoursOfDoneWork)/Float(self.selectedTeam.teamWorkloadInHours)

                    repository.deleteTask(projectDocId: self.selectedProjectDocId, teamDocId: self.selectedTeam.docId, task: task)
                    allTasks.remove(at: index)
                                           
                    self.calculateWorkload()
                    
                    
                    

                }
        }
    
    func getSelectedTeam(){
        repository.isLoading = true
        repository.getSelectedTeam(teamDocId: selectedTeam.docId, projectDocId: selectedProjectDocId) { team in
            self.selectedTeam = team
            print("getSelectedTeam Called")
            print("selected team info: \(self.selectedTeam)")
        }
    }

    
    func getTasks() {
        DispatchQueue.main.async { [self] in
            repository.isLoading = true
                self.repository.getTasks(projectDocId: selectedProjectDocId, teamDocId: selectedTeam.docId, completion: { (tasks, docIDs) in
                    self.allTasks.removeAll()
                    self.allTasks.append(contentsOf: tasks)
                    
                        self.taskDocIds.removeAll()
                        self.taskDocIds.append(contentsOf: docIDs)
                       
                        self.repository.isLoading = false

                    })

        }
    }

    func calculateTaskWorkload(days: Int, hours: Int) -> Int{
        let workload = (days*24)+hours
        return workload
    }
    
    func calculateWorkload(){
        print("teamHours total: \(selectedTeam.teamWorkloadInHours)")
        var doneHours: [Int] = []
        
        for task in allTasks {
            if task.isDone {
                doneHours.append(task.workLoad)
            }
        }

            let sumOfDoneHours = doneHours.reduce(0, +)
            print("The sum of done hours is: \(sumOfDoneHours)")
            
            self.selectedTeam.hoursOfDoneWork = sumOfDoneHours
            
            let workDonePercent = Float(sumOfDoneHours)/Float(self.selectedTeam.teamWorkloadInHours)
            
            print("Work done hours: \(self.selectedTeam.teamWorkloadInHours)")
            print("sum of done hours: \(sumOfDoneHours/100)")
            print("percent: \(workDonePercent)")
            if workDonePercent.isNaN {
                self.selectedTeam.workDonePercentage = 0.0
            } else {
                self.selectedTeam.workDonePercentage = workDonePercent
                
            }
        
 
    }
    
    func saveDoneWork(){
        for task in allTasks {
            repository.updateTaskData(task: task, teamDocId: selectedTeam.docId, projectDocId: selectedProjectDocId)
            
            }

        self.repository.updateTeamData(team: self.selectedTeam, projectDocId: self.selectedProjectDocId)
        
    }
    

}
