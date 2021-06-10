//
//  JournalTests.swift
//  JournalTests
//
//  Created by Cyril Garcia on 6/5/21.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {
    
    struct MockJournalData {
        var title: String = UUID().uuidString
        var content: String = UUID().uuidString
    }
    
    final class MockJournalManager: JournalManager {
        override func readFromJSON() {}
        override func writeToJSON() -> Result<Any?, JournalError> {
            return .success(journals)
        }
    }
    
    func testDuplicateTitleEntries() {
        let manager = MockJournalManager(URL(fileURLWithPath: ""))
        
        let _ = manager.execute(JournalCreate("Apple", "Content"))
        let _ = manager.execute(JournalCreate("Apple", "Content1"))
        let _ = manager.execute(JournalCreate("Apple", "Content2"))
        let _ = manager.execute(JournalCreate("Apple", "Content3"))
        let _ = manager.execute(JournalCreate("Apple", "Content4"))
        
        let journals = manager.journalTitleReference
        
        XCTAssertEqual(journals.count, 5)
        XCTAssertTrue(journals.contains("Apple"))
        XCTAssertTrue(journals.contains("Apple-1"))
        XCTAssertTrue(journals.contains("Apple-2"))
        XCTAssertTrue(journals.contains("Apple-3"))
        XCTAssertTrue(journals.contains("Apple-4"))
        
        let _ = manager.execute(JournalList())
        
    }

}
