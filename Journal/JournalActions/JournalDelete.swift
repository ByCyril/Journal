//
//  JournalDelete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation

struct JournalDelete: JournalAction {
    
    private let index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        
        if index >= journals.count {
            return .error("Index is out of range")
        }
        
        journals.remove(at: index)
        
        return .save
    }
}
