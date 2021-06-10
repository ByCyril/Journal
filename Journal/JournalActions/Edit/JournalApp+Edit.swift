//
//  JournalApp+Edit.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation
import ArgumentParser

// ./Journal edit 2 --new-title "new title" --new-content "...."

// ./Journal edit --new-title "new title"

extension JournalApp {
    
    struct Edit: ParsableCommand {
 
        @Argument(help: "Index to edit") var selectedIndex: Int?
        
        @Option(name: .long, help: "") var newTitle: String?
        @Option(name: .long, help: "") var newContent: String?
        
        func run() throws {
            
            if let selectedIndex = selectedIndex {
                
                var editJournal = JournalEdit(selectedIndex)
                
                if let newTitle = newTitle {
                    editJournal.updatedTitle = newTitle
                }
                
                if let newContent = newContent {
                    editJournal.updatedContent = newContent
                }
                
                let res = manager.execute(editJournal)
                process(res)
                
                return
            }
            
            let listJournals = JournalList()
            let _ = manager.execute(listJournals)
            
            print("Select the Journal you want to edit")
            
            let index = Int(getInput())!
            
            var editJournal = JournalEdit(index)
            
            if let newTitle = newTitle {
                editJournal.updatedTitle = newTitle
            }
            
            if let newContent = newContent {
                editJournal.updatedContent = newContent
            }
    
            let res = manager.execute(editJournal)
            process(res)
            
        }
    }
}
