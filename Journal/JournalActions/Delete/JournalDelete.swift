//
//  JournalDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation

struct JournalDelete: JournalAction {
    
    enum ContentType {
        case title(String)
        case all
    }
    
    private var type: ContentType
    
    init(_ type: ContentType) {
        self.type = type
    }
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        if journals.isEmpty {
            return .error("Journal is Empty.")
        }
        
        switch type {
        case .title(let title):
            for (i, journal) in journals.enumerated() {
                if journal.title.lowercased() == title {
                    journals.remove(at: i)
                }
            }
            break
        case .all:
            journals.removeAll()
            break
            
        }
        
        return .writeToJSON
    }
}
