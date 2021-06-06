//
//  JournalTests.swift
//  JournalTests
//
//  Created by Cyril Garcia on 6/5/21.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {

    private let manager: JournalManager = JournalManager(URL(fileURLWithPath: "/Users/cy/Desktop/Journal/JournalTests/Journal-Demo.json"))
    
    func testCreatingJournals() {
        let journalTitle = UUID().uuidString
        let entityTitle = UUID().uuidString
        let content = UUID().uuidString
        
        let action = JournalCreate(journalTitle: journalTitle,
                                   entityTitle: entityTitle,
                                   content: content)
        
        let results = manager.execute(action)
        
        switch results {
        case .success(let success):
            XCTAssert(success == "Success!")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "Error")
        }
        
        XCTAssertEqual(manager.journals.first!.title, journalTitle)
        XCTAssertEqual(manager.journals.first!.entries.first!.title, entityTitle)
        XCTAssertEqual(manager.journals.first!.entries.first!.content, content)
        
        testDelete(journalTitle, entityTitle)
    }
    
    func testDelete(_ journal: String,_ entry: String) {
        
        switch manager.execute(JournalDelete(entry: entry)) {
        case .success(let success):
            XCTAssert(success == "Success!")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "Error")
        }
        
        XCTAssertEqual(manager.journals.count, 1)
        XCTAssertEqual(manager.journals.first!.entries.count, 0)
        
        switch manager.execute(JournalDelete(journal: journal)) {
        case .success(let success):
            XCTAssert(success == "Success!")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "Error")
        }
        
        XCTAssertEqual(manager.journals.count, 0)
    }
    
    func testMultipleEntries() {
    
    }
    
}
