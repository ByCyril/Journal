//
//  JournalTests.swift
//  JournalTests
//
//  Created by Cyril Garcia on 6/5/21.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {
    
    class MockJournalManager: JournalManager {
        override func writeToJSON() -> Result<Any?, Error> {
            return .success(journals)
        }
    }
    
    func testCreateNewJournal() {
        
        let mockManager: MockJournalManager = MockJournalManager(URL(fileURLWithPath: ""), [:])
        
        let journalTitle: String = UUID().uuidString
        let entryTitle: String = UUID().uuidString
        let content: String = UUID().uuidString
        
        let action = JournalCreate(journalTitle, entryTitle, content: content)
        let result = mockManager.execute(action)
        
        switch result {
        case .success(let res):
            let journals = res as! [String: Journal]
            XCTAssertEqual(journals[journalTitle]!.title, journalTitle)
        case .failure(let error):
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
    
    func testCreateJournalWithDuplicates() {
        let mockManager: MockJournalManager = MockJournalManager(URL(fileURLWithPath: ""), [:])

        let journalTitle: String = "Mock Journal Title"
        
        let action1 = JournalCreate(journalTitle, "Entry", content: UUID().uuidString)
        let _ = mockManager.execute(action1)
        
        let action2 = JournalCreate(journalTitle, "Entry", content: UUID().uuidString)
        let result = mockManager.execute(action2)
        
        switch result {
        case .success(let res):
            let journals = res as! [String: Journal]
            XCTAssertEqual(journals[journalTitle]!.title, journalTitle)
            XCTAssertEqual(journals[journalTitle]!.entries.count, 2)
            XCTAssertNotNil(journals[journalTitle]!.entries["Entry"])
            XCTAssertNotNil(journals[journalTitle]!.entries["Entry-1"])
            
        case .failure(let error):
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
}
