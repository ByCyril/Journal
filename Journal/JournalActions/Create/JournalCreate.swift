//
//  JournalCreate.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

final class JournalCreate: JournalAction {
      
    private let journalTitle: String
    private let entryTitle: String
    private let content: String
    
    init(_ journalTitle: String,_ entryTitle: String, content: String) {
        self.journalTitle = journalTitle
        self.entryTitle = entryTitle
        self.content = content
    }

    func action(with library: inout [String: Journal]) -> JournalError? {

        let entry = Entry(title: entryTitle, content: content)

        if let existingJournal = library[journalTitle] {
            addNew(entry, in: existingJournal, with: entryTitle)
        } else {
            let newJournal = Journal(journalTitle)
            newJournal.entries[entryTitle] = entry
            
            library[journalTitle] = newJournal
        }
        
        return nil
    }
    
    func addNew(_ entry: Entry, in journal: Journal, with title: String) {
        if journal.entries[title] == nil {
            journal.entries[title] = entry
            return
        }
        
        let count = Int(title.components(separatedBy: "-").last ?? "0") ?? 0 + 1
        
        addNew(entry, in: journal, with: title + "-\(count)")
    }
}
