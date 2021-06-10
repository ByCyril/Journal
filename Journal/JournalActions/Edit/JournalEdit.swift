//
//  JournalEdit.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation

struct JournalEdit: JournalAction {
    
    private let index: Int
    
    var updatedTitle: String?
    var updatedContent: String?
    
    init(_ index: Int) {
        self.index = index
    }
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        
        if index >= journals.count {
            return .error("Index out of range.")
        }
        
        if let updatedTitle = updatedTitle {
            journals[index].title = updatedTitle
        }
        
        if let updatedContent = updatedContent {
            journals[index].content = updatedContent
        }
        
        return .save
    }
}
