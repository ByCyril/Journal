//
//  JournalAppSort+Extension.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    struct Sort: ParsableCommand {
        @Flag(name: .long, help: "Sort by Title") var entryTitle: Bool = false
        @Flag(name: .long, help: "Sort by date created") var dateCreated: Bool = false
        @Flag(name: .long, help: "Sort by last updated") var lastUpdated: Bool = false
        @Flag(name: .long, help: "Sort by content length") var contentLength: Bool = false
        
        @Flag(name: .long, help: "Ascending") var ascending: Bool = false
        
        func run() throws {
            var action: JournalSort?
                
            if entryTitle {
                action = JournalSort(.title, !ascending)
            } else if dateCreated {
                action = JournalSort(.dateCreated, !ascending)
            } else if lastUpdated {
                action = JournalSort(.lastUpdated, !ascending)
            } else if contentLength {
                action = JournalSort(.contentSize, !ascending)
            }
            
            if let action = action {
                let res = manager.execute(action)
                process(res)
            }
        }
    }
}
