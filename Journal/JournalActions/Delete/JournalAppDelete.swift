//
//  JournalAppDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
//    ./Journal delete --journal Diary
//    ./Journal delete --entry "title of entry" --journal
    struct Delete: ParsableCommand {
        @Option(name: .long, help: "Title of Journal") var journal: String
        @Option(name: .long, help: "Title of Entry from a specified Journal") var entry: String?
        @Flag(name: .short, help: "Confirm Action") var confirm: Bool = false
        
        func run() throws {
            if confirm {
                let action = JournalDelete(journalTitle: journal, entry)
                process(manager.execute(action))
            } else {
                print("Failed to delete. Please confirm action with -c")
            }
        }
    }
}
