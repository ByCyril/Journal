//
//  JournalList.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

final class JournalList: JournalAction {
    
    enum Category {
        case journal(String)
        case journalTitle
    }
    
    private var category: Category
    
    init(_ category: Category) {
        self.category = category
    }
    
    func action(with library: inout [String: Journal]) -> JournalError? {
        if library.isEmpty {
            return JournalError.isEmpty()
        }
        
        switch category {
        case .journalTitle:
            listJournalTitles(library)
            
        case .journal(let title):
            if let journal = library[title] {
                listJournalEntries(from: journal)
            } else {
                return .couldNotFindJournal(title)
            }
        }
        
        return nil
    }
    
    func listJournalTitles(_ journals: [String: Journal]) {
        print("*********************")
        for title in Array(journals.keys) {
            print(title)
        }
        print("*********************")
    }
    
    func listJournalEntries(from journal: Journal) {
        print("*********************")
        for (title, entry) in journal.entries {
            print(title)
            print(entry.content)
            print(entry.createdAt)
            print("")
        }
        print("*********************")
    }
}
