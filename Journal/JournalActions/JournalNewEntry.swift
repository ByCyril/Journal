//
//  JournalNewEntry.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

class JournalNewEntry: JournalAction {
    var url: URL?
    
    private let journalTitle: String
    private let entry: Entry
    
    init(journalTitle: String, entry: Entry) {
        self.journalTitle = journalTitle
        self.entry = entry
    }
    
    func action(with journals: inout [Journal], with url: URL) {
        self.url = url
        for (i, journal) in journals.enumerated() {
            if journal.title == journalTitle {
                journals[i].entries.append(entry)
                break
            }
        }
    }
    
}
