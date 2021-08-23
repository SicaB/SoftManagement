//
//  ProjectRepository.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 23/06/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ProjectRepository {
    
    private let db = Firestore.firestore()
    @Published var isLoading = true {
        didSet {
            print("is loading is now: \(isLoading)")
        }
    }
    
    
    func saveUser(userId: String, user: User) {
        isLoading = true
            let ref = self.db.collection("Users").document()
            ref.setData([
                "id": userId,
                "name": user.name,
                "username": user.username,
                "email": user.email,
                "password": user.password,
                "created": FirebaseFirestore.Timestamp.init(date: Date())
            ], merge: true)  { err in
                self.isLoading = false
                if let err = err {
                    print("Debug: Error writing to users document: \(err)")
                } else {
                    print("Debug: User succesfully created")
                }
            }
    }
    
    func saveProject(input: Project, userDocId: String) {
        isLoading = true
            let ref = self.db.collection("Users").document(userDocId)
            ref.collection("Projects").document().setData([
                "id": input.id as Any,
                "name": input.name,
                "startDate": input.startDate,
                "deadLine": input.deadLine,
                "progressCount": input.progressCount,
                "created": FirebaseFirestore.Timestamp.init(date: Date())
            ], merge: true)  { err in
                self.isLoading = false
                if let err = err {
                    print("Debug: Error writing to projects document: \(err)")
                } else {
                    print("Debug: Project succesfully created")
                }
            }
    }
    
    func saveTeamToProject(input: Team, docId: String, userDocId: String) {
            self.isLoading = true
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(docId)
            
            ref.collection("Teams").document().setData([
                "id": input.id,
                "name": input.name,
                "teamWorkloadInHours": input.teamWorkloadInHours,
                "hoursOfDoneWork": input.hoursOfDoneWork,
                "workDonePercentage": input.workDonePercentage,
                "tasks": [],
                "created": FirebaseFirestore.Timestamp.init(date: Date())
                
            ], merge: true) { err in
                self.isLoading = false
                if let err = err {
                    print("Debug: Error writing to teams document: \(err)")
                } else {
                    print("Debug: Team succesfully created")
                }
            }
    }
    
    func saveTask(input: Task, teamDocId: String, projectDocId: String, userDocId: String) {
            self.isLoading = true
            var newPercentOfDoneWork: Float = 0.0
            var newWorkload: Int = 0
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId)
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    let teamWorkloadInHours = document.get("teamWorkloadInHours") as? Int ?? 0
                    newWorkload = teamWorkloadInHours+input.workLoad
                    let hoursOfDoneWork = document.get("hoursOfDoneWork") as? Int ?? 0
                    newPercentOfDoneWork = Float(hoursOfDoneWork)/Float(newWorkload)
                    ref.updateData([
                        "teamWorkloadInHours": newWorkload,
                        "workDonePercentage": newPercentOfDoneWork,
                        "tasks": FieldValue.arrayUnion([input.title])
                    ])
                    self.isLoading = false
                    print("task title has been saved in team tasktitle array!")
                }
                else  {
                    print("Could not save Task in team tasktitle array!")
                }
            }
            ref.collection("Tasks").document().setData([
                "id": input.id,
                "title": input.title,
                "description": input.description,
                "workLoad": input.workLoad,
                "created": FirebaseFirestore.Timestamp.init(date: Date())
            ], merge: true) { err in
                self.isLoading = false
                if let err = err {
                    print("Debug: Error writing to task document: \(err)")
                } else {
                    print("Debug: Task succesfully created")
                }
            }
    }
    
    func getSelectedTeam(userDocId: String, teamDocId: String, projectDocId: String, completion: @escaping (Team) -> Void) {
            self.isLoading = true
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId)
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    
                    //     let data = document.data()
                    let docId = document.documentID
                    let name = document.get("name") as? String ?? ""
                    let tasks = document.get("tasks") as? [String] ?? []
                    //                    let tasks = data?.compactMap {DocumentSnapshot -> Task? in return try? document.data(as: Task.self)} ?? []
                    let teamWorkloadInHours = document.get("teamWorkloadInHours") as? Int ?? 0
                    let hoursOfDoneWork = document.get("hoursOfDoneWork") as? Int ?? 0
                    let workDonePercentage = document.get("workDonePercentage") as? Float ?? 0.0
                    
                    
                    self.isLoading = false
                    let teamInfo = Team(name: name, docId: docId, tasks: tasks, teamWorkloadInHours: teamWorkloadInHours, hoursOfDoneWork: hoursOfDoneWork, workDonePercentage: workDonePercentage)
                    
                    
                    completion(teamInfo)
                    
                }
            }
    }
    
    func getUser(userId: String, completion: @escaping (User) -> Void) {
            self.isLoading = true
            
        var user = User(docId: "", name: "", username: "", email: "", password: "")
            let collectionRef = self.db.collection("Users").whereField("id", isEqualTo: userId)
            
            collectionRef.getDocuments  { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err.localizedDescription)")
                    
                } else {
                    guard let snap = snapshot else {
                        return
                    }
                    for document in snap.documents {
                        
                        //let data = document.data()
                       
                        let docId = document.documentID
                        let name = document.get("name") as? String ?? ""
                        let username = document.get("username") as? String ?? ""
                        let email = document.get("email") as? String ?? ""
                        let password = document.get("password") as? String ?? ""
                        
                        self.isLoading = false
                        let userDB = User(docId: docId, name: name, username: username, email: email, password: password)
                        user = userDB
                        
                    }
                    self.isLoading = false
                    completion(user)
                    
                }
            }
        
    }
    
    func getAllProjects(userDocId: String, completion: @escaping ([Project], [String]) -> Void) {
        self.isLoading = true
        let collectionRef = self.db.collection("Users").document(userDocId).collection("Projects").order(by: "created", descending: true)
                var projects = [Project]()
                var documentID = [String]()
            
                collectionRef.getDocuments  { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err.localizedDescription)")
                } else {
                    guard let snap = snapshot else {
                        return
                    }
                    for document in snap.documents {
                        let data = document.data()
                        let docId = document.documentID
                        let names = data["name"] as? String ?? ""
                        let progressCount = data["progressCount"] as? Float ?? 0.0
                        let projectsDB = Project(name: names, docId: docId, progressCount: progressCount)
                        projects.append(projectsDB)
                        documentID.append(docId)
                    }
                    self.isLoading = false
                    completion(projects, documentID)
                }
            }
    }
    
    func getTeams(userDocId: String, projectDocId: String, completion: @escaping ([Team], [String]) -> Void) {
            self.isLoading = true
            let collectionRef = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").order(by: "created", descending: true)
            
            var teams = [Team]()
            var documentID = [String]()
            
            collectionRef.getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err.localizedDescription)")
                    
                } else {
                    guard let snap = snapshot else {
                        return
                    }
                    for document in snap.documents {
                        
                        let data = document.data()
                        let docId = document.documentID
                        let names = data["name"] as? String ?? ""
                        let tasks = document.get("tasks") as? [String] ?? []
                        let teamWorkloadInHours = data["teamWorkloadInHours"] as? Int ?? 0
                        let hoursOfDoneWork = data["hoursOfDoneWork"] as? Int ?? 0
                        let workDonePercentage = data["workDonePercentage"] as? Float ?? 0.0
                        
                        self.isLoading = false
                        let teamsDB = Team(name: names, docId: docId, tasks: tasks, teamWorkloadInHours: teamWorkloadInHours, hoursOfDoneWork: hoursOfDoneWork, workDonePercentage: workDonePercentage)
                        
                        teams.append(teamsDB)
                        documentID.append(docId)
                        
                        print("From repo1: \(names)")
                        
                    }
                    self.isLoading = false
                    completion(teams, documentID)
                    
                }
            }
        
    }
    
    func getTasks(userDocId: String, projectDocId: String, teamDocId: String, completion: @escaping ([Task], [String]) -> Void) {
            print("repo get tasks: projectdocid is: \(projectDocId) and teamdocid is: \(teamDocId)")
            let collectionRef = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId).collection("Tasks").order(by: "created", descending: true)
            
            var tasks = [Task]()
            var documentID = [String]()
            
            collectionRef.getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting document: \(err.localizedDescription)")
                    
                } else {
                    guard let snap = snapshot else {
                        return
                    }
                    for document in snap.documents {
                        
                        let data = document.data()
                        let docId = document.documentID
                        let titles = data["title"] as? String ?? ""
                        let descriptions = data["description"] as? String ?? ""
                        let workLoads = data["workLoad"] as? Int ?? 0
                        let isDone = data["isDone"] as? Bool ?? false
                        
                        let tasksDB = Task(docId: docId, title: titles, description: descriptions, workLoad: workLoads, isDone: isDone)
                        tasks.append(tasksDB)
                        documentID.append(docId)
                        
                    }
                    
                    completion(tasks, documentID)
                    
                }
            }
    }
    
    func updateProjectData(userDocId: String, input: Project, projectDocId: String) {
            self.isLoading = true
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId)
            
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    ref.updateData([
                        "name": input.name,
                        "startDate": input.startDate,
                        "deadLine": input.deadLine,
                        "progressCount": input.progressCount
                        
                    ])
                    self.isLoading = false
                    print("Project has been updated")
                } else {
                    print("Could not update the Project")
                }
            }
        
    }
    
    func updateTeamData(userDocId: String, team: Team, projectDocId: String) {
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(team.docId)
            
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    ref.updateData([
                        "hoursOfDoneWork": team.hoursOfDoneWork,
                        "workDonePercentage": team.workDonePercentage,
                        
                    ])
                    print("Team has been updated")
                } else {
                    print("Could not update the team")
                }
            }
        
    }
    
    func updateTaskData(userDocId: String, task: Task, teamDocId: String, projectDocId: String) {
            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId).collection("Tasks").document(task.docId)
            
            ref.getDocument { (document, error) in
                if let document = document, document.exists {
                    ref.updateData([
                        "id": task.id,
                        "title": task.title,
                        "description": task.description,
                        "workLoad": task.workLoad,
                        "isDone": task.isDone
                        
                    ])
                    print("Task has been updated")
                } else {
                    print("Could not update the task")
                }
                
            }
    }
    
    func anyProjectsInDatabase(userDocId: String, completion: @escaping (Bool) -> Void) {
            
            let collectionRef = self.db.collection("Users").document(userDocId).collection("Projects")
            
            collectionRef.getDocuments  { (snapshot, err) in
                
                if snapshot!.documents.count > 0 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
    }
    
    func deleteProject(userDocId: String, docId: String){
        self.isLoading = true
            self.db.collection("Users").document(userDocId).collection("Projects").document(docId).delete() { error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Debug: project deleted")
                }
            }
            self.isLoading = false
        }
    
    func deleteTeam(userDocId: String, projectDocId: String, teamDocId: String){
        self.isLoading = true
            self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId).delete() { error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Debug: team deleted")
                    
                }
                
            }
            
            self.isLoading = false
        
    }
    
    func deleteTask(userDocId: String, projectDocId: String, teamDocId: String, task: Task){
        self.isLoading = true
        var newPercentOfDoneWork: Float = 0.0
        var newHoursOfDoneWork: Int = 0
        var newWorkload: Int = 0

            let ref = self.db.collection("Users").document(userDocId).collection("Projects").document(projectDocId).collection("Teams").document(teamDocId)
            
            ref.collection("Tasks").document(task.docId).delete() { error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Debug: task deleted")
                    
                    ref.getDocument { (document, error) in
                        if let document = document, document.exists {
                            
                            let teamWorkloadInHours = document.get("teamWorkloadInHours") as? Int ?? 0
                            newWorkload = teamWorkloadInHours-task.workLoad
                            
                            let hoursOfDoneWork = document.get("hoursOfDoneWork") as? Int ?? 0
                            
                            if task.isDone {
                                let doneWork = hoursOfDoneWork - task.workLoad
                                newHoursOfDoneWork = doneWork
                                newPercentOfDoneWork = Float(newHoursOfDoneWork)/Float(newWorkload)
                            } else {
                                newHoursOfDoneWork = hoursOfDoneWork
                                newPercentOfDoneWork = Float(hoursOfDoneWork)/Float(newWorkload)
                            }
                            
                            
                            ref.updateData([
                                "teamWorkloadInHours": newWorkload,
                                "hoursOfDoneWork": newHoursOfDoneWork,
                                "workDonePercentage": newPercentOfDoneWork,
                                "tasks" : FieldValue.arrayRemove([task.title])
                            ])
                            
                            
                            print("task title has been removed in team tasktitle array!")
                            
                        }
                        else  {
                            print("Could not delete Task in team tasktitle array!")
                        }
                        
                    }
                    
                }
            }
            self.isLoading = false
        }
    
}
