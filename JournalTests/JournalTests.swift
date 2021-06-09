//
//  JournalTests.swift
//  JournalTests
//
//  Created by Cyril Garcia on 6/5/21.
//

import XCTest
@testable import Journal

class JournalTests: XCTestCase {
    
    final class MockJournalManager: JournalManager {
        override func readFromJSON() {}
        override func writeToJSON() -> Result<Any?, JournalError> {
            return .success(journals)
        }
    }
    
    func testDuplicateTitleEntries() {
        let manager = MockJournalManager(URL(fileURLWithPath: "/Users/cy/Desktop/Journal/JournalTests/Journal-Demo.json"))
        
        let _ = manager.execute(JournalCreate("Apple", "Content"))
        let _ = manager.execute(JournalCreate("Apple", "Content1"))
        let _ = manager.execute(JournalCreate("Apple", "Content2"))
        let _ = manager.execute(JournalCreate("Apple-1", "Content3"))
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
    
    struct Test {
        var title: String
        var content: String
    }
 
    func testSorting() {
        let manager = MockJournalManager(URL(fileURLWithPath: "/Users/cy/Desktop/Journal/JournalTests/Journal-Demo.json"))
        
        var journals: [JournalAction] = []
        
        var tests = [Test(title: "abc", content: "abccda"),
                     Test(title: "cda", content: "ghdhsfyjsytd"),
                     Test(title: "abcad", content: "gilufkyujytkh"),
                     Test(title: "142", content: "fhsrt"),
                     Test(title: "", content: "")]
        
        tests.sort { $0.title > $1.title }
        
        tests.forEach { test in
            journals.append(JournalCreate(test.title, test.content))
        }
        
        journals.forEach { action in
            let _ = manager.execute(action)
        }
        
        let sortingByTitleRes = manager.execute(JournalSort(.title))
        let sortedJournalsByTitle = try! sortingByTitleRes.get() as! [Journal]
        
        for i in 0..<tests.count {
            XCTAssertEqual(sortedJournalsByTitle[i].title, tests[i].title)
            XCTAssertEqual(sortedJournalsByTitle[i].content, tests[i].content)
        }
        
        tests.sort { $0.content.count < $1.content.count }
        
        let sortingByDateCreatedRes = manager.execute(JournalSort(.contentSize))
        let sortedJournalsByDateCreated = try! sortingByDateCreatedRes.get() as! [Journal]
        
        for i in 0..<tests.count {
            XCTAssertEqual(sortedJournalsByDateCreated[i].title, tests[i].title)
            XCTAssertEqual(sortedJournalsByDateCreated[i].content, tests[i].content)
        }
        
    }
    
    func testDelete() {
        let manager = MockJournalManager(URL(fileURLWithPath: ""))
        
        var journals: [JournalAction] = []
        
        var tests = [Test(title: "abc", content: "abccda"),
                     Test(title: "cda", content: "ghdhsfyjsytd"),
                     Test(title: "abcad", content: "gilufkyujytkh"),
                     Test(title: "142", content: "fhsrt"),
                     Test(title: "", content: "")]
                
        tests.forEach { test in
            journals.append(JournalCreate(test.title, test.content))
        }
        
        journals.forEach { action in
            let _ = manager.execute(action)
        }
        
        let res = manager.execute(JournalDelete("abc"))
        tests.removeFirst()
        let journalsAfterDeleting = try! res.get() as! [Journal]
        
        XCTAssertEqual(journalsAfterDeleting.count, tests.count)
        
        for i in 0..<tests.count {
            XCTAssertEqual(tests[i].title, journalsAfterDeleting[i].title)
        }
    }
    
}
