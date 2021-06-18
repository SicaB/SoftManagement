//
//  Task.swift
//  SoftManagement
//
//  Created by Sacha Behrend on 17/06/2021.
//

import SwiftUI

struct Task: Codable {
    var id: String = UUID().uuidString
    var name = ""
    var team = ""
    var teamMember = ""
}
