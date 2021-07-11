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
            self.db.collection("Projects").document().setData([
                "id": input.id as Any,
                "name": input.name,
                "startDate": input.startDate,
                "deadLine": input.deadLine,
             //   "projectOwner": input.projectOwner,
                "teams": input.teams,
              //  "teamMember": input.teamMember,
             //   "task": input.task,
                "created": Firebase.Timestamp.init(date: Date())
            ], merge: true) { err in
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
        isLoading = true
        DispatchQueue.main.async {
            let docRef = self.db.collection("Projects").document(docId)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                        docRef.updateData([
                            "teams": FieldValue.arrayUnion([input.name])
                        ])
                            print("Team has been saved to project!")
                        }
                        else  {
                            print("Could not save Team to project!")
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
                        let docID = document.documentID
                        let names = data["name"] as? String ?? ""
                        let teams = data["teams"] as? [Team] ?? []
                        
                        let projectsDB = Project(name: names, teams: teams)
                        projects.append(projectsDB)
                        documentID.append(docID)
                    }
                    completion(projects, documentID)
                
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
    
    func deleteTeam(projectDocId: String, teamDocId: [String], team: Team){
        
//        indexSet.forEach { index in
//            let teamToDelete = teamDocId[index]
            
            let teamData: [String: Any] =
            [
                "id" : team.id as Any,
                "name" : team.name,
            ]

            DispatchQueue.main.async {
                self.db.collection("Projects").document(projectDocId).updateData([
                    "teams" : FieldValue.arrayRemove([teamData])
                
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



