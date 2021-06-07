//
//  JournalAppList.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    struct List: ParsableCommand {
        @Flag(name: .long, help: "List all Journal titles from your library") var library: Bool = false
        @Option(name: .long, help: "List all entries from specified journal") var title: String?
        
        func run() throws {
            
            if library {
                let action = JournalList(.journalTitle)
                process(manager.execute(action))
                return
            }
            
            if let title = title {
                let action = JournalList(.journal(title))
                process(manager.execute(action))
                return
            }
            
        }
    }
}
