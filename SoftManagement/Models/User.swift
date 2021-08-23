//
//  User.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 14/06/2021.
//

import SwiftUI

struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var docId = ""
    var name = ""
    var username = ""
    var email = ""
    var password = ""
    
    init(docId: String, name: String, username: String, email: String, password: String) {
        self.docId = docId
        self.name = name
        self.username = username
        self.email = email
        self.password = password

    }

}
