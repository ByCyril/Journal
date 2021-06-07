//
//  JournalDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

final class JournalDelete: JournalAction {
    
    private let journalTitle: String
    private let entryTitleToDelete: String?
    
    init(journalTitle: String,_ entryTitleToDelete: String? = nil) {
        self.journalTitle = journalTitle
        self.entryTitleToDelete = entryTitleToDelete
    }
    
    func action(with library: inout [String : Journal]) -> JournalError? {
        if library.isEmpty {
            return JournalError.isEmpty("Library is empty")
        }
        
        guard let journal = library[journalTitle] else {
            return .couldNotFindJournal(journalTitle)
        }
        
        if let entryToDelete = entryTitleToDelete {
            if journal.entries.removeValue(forKey: entryToDelete) == nil {
                return .couldNotFindEntry(entryToDelete)
            }
            library[journalTitle] = journal
            return nil
        }
        
        library.removeValue(forKey: journalTitle)
        
        return nil
    }
    
    
    
}
