//
//  JournalCreate.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

final class JournalCreate: JournalAction {
    
    var url: URL?
    
    private let journalTitle: String
    private let entryTitle: String
    private let content: String
    
    init(_ journalTitle: String,_ entryTitle: String, content: String) {
        self.journalTitle = journalTitle
        self.entryTitle = entryTitle
        self.content = content
    }
    
    func action(with journals: inout [String : Journal], with url: URL) {
        self.url = url
        
        let entry = Entry(title: entryTitle, content: content)
        
        if let journal = journals[journalTitle] {
            journal.entries[entryTitle] = entry
        } else {
            let journal = Journal(journalTitle)
            journal.entries[entryTitle] = entry
        }
        
    }
}
