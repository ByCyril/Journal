//
//  JournalDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

class JournalDelete: JournalAction {

    var url: URL?
    
    var journalTitle: String?
    var entryTitle: String?
    
    func action(with journals: inout [Journal], with url: URL) {
        self.url = url
        if let journal = journalTitle {
            
            for (i, storedJournal) in journals.enumerated() {
                if storedJournal.title == journal {
                    journals.remove(at: i)
                    return
                }
            }
        } else if let entry = entryTitle {
            for journal in journals {
                for (i, storedEntry) in journal.entries.enumerated() {
                    if storedEntry.title == entry {
                        journal.entries.remove(at: i)
                        print(journal.entries)
                        return
                    }
                }
            }
        }
    }
    
    init(journal: String) {
        self.journalTitle = journal
    }
    
    init(entry: String) {
        self.entryTitle = entry
    }
}
