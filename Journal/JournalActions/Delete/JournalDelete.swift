//
//  JournalDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation

struct JournalDelete: JournalAction {
   
    let title: String
    
    init(_ title: String) {
        self.title = title.lowercased()
    }
  
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        if journals.isEmpty {
            return .error("Journal is Empty.")
        }
        
        for (i, journal) in journals.enumerated() {
            if journal.title.lowercased() == title {
                journals.remove(at: i)
            }
        }
        
        return .writeToJSON
        
    }
    
    
}
