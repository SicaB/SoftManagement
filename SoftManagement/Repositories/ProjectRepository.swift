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
import Combine

class ProjectRepository {
   
    private let db = Firestore.firestore()
    @Published var isLoading = true
    //@Published var dbHasBeenChecked = false
 
    let group = DispatchGroup()
    
    
//    func get() {
//        db.collection("Projects").addSnapshotListener { (snapshot, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            self.projects = snapshot?.documents.compactMap {
//                try? $0.data(as: Project.self)
//
//            } ?? []
//
//        }
//    }
    
//    func addProject(input: Project) {
//        do {
//            let _ = try db.collection("Projects").addDocument(from: input)
//        }
//        catch {
//            print("error")
//        }
//    }
    
    func saveProject(input: Project) {
        isLoading = true
        DispatchQueue.main.async {
            let ref = self.db.collection("Projects").document()
                ref.setData([
                "id": input.id as Any,
                "name": input.name,
                "startDate": input.startDate,
                "deadLine": input.deadLine,
             //   "projectOwner": input.projectOwner,
              //  "teamMember": input.teamMember,

                "created": Firebase.Timestamp.init(date: Date())
            ], merge: true)  { err in
                    self.isLoading = false
                    if let err = err {
                        print("Debug: Error writing to projects document: \(err)")
                    } else {
                        print("Debug: Project succesfully created")
                    }
                }

        }
    }
    
    
    func saveTeamToProject(input: Team, docId: String) {
        DispatchQueue.main.async {
        let ref = self.db.collection("Projects").document(docId)
        ref.collection("Teams").document().setData([
            "id": input.id,
            "name": input.name,
            "tasks": input.tasks,
            "created": Firebase.Timestamp.init(date: Date())
        
        ], merge: true) { err in
            self.isLoading = false
            if let err = err {
                print("Debug: Error writing to teams document: \(err)")
            } else {
                print("Debug: Team succesfully created")
            }
        }
    }
    }
    

    
    func saveTask(input: Task, teamDocId: String, projectDocId: String) {
        DispatchQueue.main.async {
            let ref = self.db.collection("Projects").document(projectDocId).collection("Teams").document(teamDocId)
                    ref.getDocument { (document, error) in
                        if let document = document, document.exists {
                                ref.updateData([
                                    "tasks": FieldValue.arrayUnion([input.title])
                                ])
                                    print("Task has been saved to project!")
                                }
                                else  {
                                    print("Could not save Task to project!")
                                }
                            }
      
            ref.collection("Tasks").document().setData([
            "id": input.id,
            "title": input.title,
            "description": input.description,
         //   "workLoad": input.workLoad,
            "created": Firebase.Timestamp.init(date: Date())
        
        ], merge: true) { err in
            self.isLoading = false
            if let err = err {
                print("Debug: Error writing to task document: \(err)")
            } else {
                print("Debug: Task succesfully created")
            }
        }
    }
    }
    
    
    func getAllProjects(completion: @escaping ([Project], [String]) -> Void) {
        
        DispatchQueue.main.async {
            let collectionRef = self.db.collection("Projects").order(by: "created", descending: true)
            
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
                       // let teams = data["teams"] as? [Team] ?? []
                        
                        let projectsDB = Project(name: names, docId: docId)
                        projects.append(projectsDB)
                        documentID.append(docId)
                    }
                    completion(projects, documentID)
                
                }
            }
        }

    }

    func getTeams(projectDocId: String, completion: @escaping ([Team], [String]) -> Void) {
        DispatchQueue.main.async {
            let collectionRef = self.db.collection("Projects").document(projectDocId).collection("Teams").order(by: "created", descending: true)
            
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
                        let tasks = data["tasks"] as? [String] ?? []
                    
                        
                        let teamsDB = Team(name: names, docId: docId, tasks: tasks)
                        
                        teams.append(teamsDB)
                        documentID.append(docId)
                        
                        print("From repo1: \(names)")
                       
                    }
                    completion(teams, documentID)
                
                }
            }
        }
    }
    
    func getTasks(projectDocId: String, teamDocId: String, completion: @escaping ([Task], [String]) -> Void) {
        DispatchQueue.main.async {
            let collectionRef = self.db.collection("Projects").document(projectDocId).collection("Teams").document(teamDocId).collection("Tasks")
            
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
                        // let workLoads = data["workLoad"] as? String ?? ""
                        
                        let tasksDB = Task(docId: docId, title: titles, description: descriptions)
                        tasks.append(tasksDB)
                        documentID.append(docId)
                        print("tasks in db: \(tasksDB)")
                    }
                    completion(tasks, documentID)
                
                }
            }
        }
    }
    
    

//    func getProjects(completion: @escaping ([String], [String]) -> Void) {
//        let collectionRef = db.collection("Projects").order(by: "created", descending: true)
//
//        var titles = [String]()
//        var documentID = [String]()
//
//        collectionRef.getDocuments  { (snapshot, err) in
//            if let err = err {
//                print("Error getting document: \(err.localizedDescription)")
//            } else {
//
//                guard let snap = snapshot else { return }
//                for document in snap.documents {
//
//                    let data = document.data()
//                    let names = data["name"] as? String ?? ""
//                    let docID = document.documentID
//
//                    let projectTitles = Project(name: names)
//                    titles.append(String(projectTitles.name))
//
//                    documentID.append(docID)
//                }
//                completion(titles, documentID)
//            }
//        }
//    }
    
    func anyProjectsInDatabase(completion: @escaping (Bool) -> Void) {
        //isLoading = true
        DispatchQueue.main.async {
            let collectionRef = self.db.collection("Projects")
               
                collectionRef.getDocuments  { (snapshot, err) in
                    //self.isLoading = false
                        if snapshot!.documents.count > 0 {
                            completion(true)
                        } else {
                            completion(false)
                        }
                }
        }
    }
    
//    func anyTeamsInDatabase(completion: @escaping (Bool) -> Void) {
//        DispatchQueue.main.async {
//            let collectionRef = self.db.collection("Projects")
//
//                collectionRef.getDocuments  { (snapshot, err) in
//                    //self.isLoading = false
//                        if snapshot!.documents.count > 0 {
//                            completion(true)
//                        } else {
//                            completion(false)
//                        }
//                }
//        }
//    }

    
    func deleteProject(at indexSet: IndexSet, docIds: [String]){
        
        indexSet.forEach { index in
            let projectToDelete = docIds[index]
            
            DispatchQueue.main.async {
                self.db.collection("Projects").document(projectToDelete).delete() { error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Debug: project deleted")
                        
                    }
                    
                }
                
                self.isLoading = false
            }
        }
        //self.isLoading = false
    }
    
    func deleteTeam(at indexSet: IndexSet, projectDocId: String, teamDocIds: [String]){
        
        indexSet.forEach { index in
            let teamToDelete = teamDocIds[index]
            
            DispatchQueue.main.async {
                self.db.collection("Projects").document(projectDocId).collection("Teams").document(teamToDelete).delete() { error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Debug: team deleted")
                        
                    }
                    
                }
                
                self.isLoading = false
            }
        }
        //self.isLoading = false
    }
    
    func deleteTask(projectDocId: String, task: Task){
        
//        indexSet.forEach { index in
//            let teamToDelete = teamDocId[index]
            
            let taskData: [String: Any] =
            [
                "id" : task.id as Any,
                "description" : task.description
            ]

        // TODO Make it work!
            DispatchQueue.main.async {
                self.db.collection("Projects").document(projectDocId).updateData([
                    "teams" : FieldValue.arrayRemove([taskData])
                
                ]) { error in
                    if let error = error {
                        print("Unable to delete team: \(error.localizedDescription)")
                    }  else {
                        print("Successfully deleted team")
                    }
                }
            
            }

            self.isLoading = false
        }
        //self.isLoading = false
    
    
    
    
}



