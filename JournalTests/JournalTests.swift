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
        
        init() {
            super.init(URL(fileURLWithPath: ""))
        }
        
        override func readFromJSON() {}
        override func writeToJSON() -> Result<Any?, Error> {
            return .success(journals)
        }
    }
    
    func testJournalCreate() {
        
        let manager = MockJournalManager()
        
        let journals = [MockJournalData(),MockJournalData(),MockJournalData(),MockJournalData(),MockJournalData()]
        
        journals.forEach { mock in
            let _ = manager.execute(JournalCreate(mock.title, mock.content))
        }
        
        for (i, mock) in journals.enumerated() {
            XCTAssertEqual(manager.journals[i].title, mock.title)
            XCTAssertEqual(manager.journals[i].content, mock.content)
        }
        
    }
    
    func testDuplicateTitleEntries() {
        let manager = MockJournalManager()
        
        struct MockJournalDataForDuplicates {
            var title: String
            var expectedTitle: String
            var content: String = UUID().uuidString
        }
        
        let mockJournals = [MockJournalDataForDuplicates(title: "Apple", expectedTitle: "Apple"),
                            MockJournalDataForDuplicates(title: "apple", expectedTitle: "apple"),
                            MockJournalDataForDuplicates(title: "Apple", expectedTitle: "Apple-1"),
                            MockJournalDataForDuplicates(title: "Apple", expectedTitle: "Apple-2"),
                            MockJournalDataForDuplicates(title: "Apple", expectedTitle: "Apple-3"),
                            MockJournalDataForDuplicates(title: "Apple", expectedTitle: "Apple-4")]
        
        for mock in mockJournals {
            let _ = manager.execute(JournalCreate(mock.title, mock.content))
        }
        
        let journals = manager.journalTitleReference
        
        XCTAssertEqual(journals.count, 6)
        XCTAssertTrue(journals.contains("Apple"))
        XCTAssertTrue(journals.contains("apple"))
        XCTAssertTrue(journals.contains("Apple-1"))
        XCTAssertTrue(journals.contains("Apple-2"))
        XCTAssertTrue(journals.contains("Apple-3"))
        XCTAssertTrue(journals.contains("Apple-4"))
        
        for (i, journal) in manager.journals.enumerated() {
            XCTAssertEqual(mockJournals[i].expectedTitle, journal.title)
            XCTAssertEqual(mockJournals[i].content, journal.content)
        }
        
    }

}
