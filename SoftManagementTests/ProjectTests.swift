//
//  LoginViewModelTest.swift
//  SoftManagementTests
//
//  Created by Sacha Behrend on 02/08/2021.
//

import XCTest
@testable import SoftManagement

class TaskTest: XCTestCase {

    func testExample() throws {
        let id = UUID()
        let task = Task(id: id, docId: "docID", title: "Hello", description: "Lorem Ipsum", workLoad: 2, isDone: false)
        
        XCTAssertEqual(id.uuidString, task.id)
        XCTAssertEqual("docID", task.docId)
        XCTAssertEqual("Lorem Ipsum", task.description)
        XCTAssertEqual("Hello", task.title)
        XCTAssertEqual(2, task.workLoad)
        XCTAssertFalse(task.isDone)
    }

}
    	
