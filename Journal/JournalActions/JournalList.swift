//
//  JournalList.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

class JournalList: JournalAction {
    
    var url: URL?
    
    func action(with journals: inout [Journal], with url: URL) {}
    
    func execute(_ journals: [Journal]) -> Result<String, Error> {

        if journals.isEmpty {
            return .failure(JournalError(localizedDescription: "Journal is currently empty"))
        }
        
        for journal in journals {
            print(journal.title)
            print("Created at \(journal.createdAt)")
        }
        
        return .success("Finished!")
        
    }
}
