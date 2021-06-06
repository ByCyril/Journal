//
//  JournalCreate.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

final class JournalCreate: JournalAction {
    
    var url: URL?
    
    let journalTitle: String
    let entityTitle: String
    let content: String
    
    init(journalTitle: String, entityTitle: String, content: String) {
        self.journalTitle = journalTitle
        self.entityTitle = entityTitle
        self.content = content
    }
    
    func action(with journals: inout [Journal], with url: URL) {
        self.url = url
        let entry = Entry(title: entityTitle, content: content)
        let journal = Journal(journalTitle)
        journal.entries.append(entry)
        journals.append(journal)
    }
}
