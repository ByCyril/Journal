//
//  JournalAppCreate.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
//    ./Journal create --journal
//    ./Journal create --entry
    
    struct Create: ParsableCommand {
        @Flag(name: .long, help: "Create new Journal") var journal: Bool = false
        @Flag(name: .long, help: "Create new Entry") var entry: Bool = false
        
        func run() throws {
            if journal {
                createNewJournal()
                return
            }
            
            if entry {
                createNewEntry()
                return
            }
        }
        
        func createNewEntry() {
            print("")
            print("Which journal do you want to write your entry in?")
            let _ = manager.execute(JournalList(.journalTitle))
            print("")
            let journalName = getInput()
            print("")
            print("Let's create your entry")
            print("Entry Title:")
            let entryTitle = getInput()
            print("")
            print("Start writing your entry: ")
            let content = getInput()

            let action = JournalCreate(journalName, entryTitle, content: content)
            
            let result = manager.execute(action)
            process(result)
            
            return
        }
        
        func createNewJournal() {
            print("")
            print("Journal Name:")
            let journalName = getInput()
            print("")
            print("Let's create your first entry.")
            print("Entry Title:")
            let entryTitle = getInput()
            print("")
            print("Start writing your entry: ")
            let content = getInput()

            let action = JournalCreate(journalName, entryTitle, content: content)
            
            let result = manager.execute(action)
            process(result)
            
            return
        }
    }
}
