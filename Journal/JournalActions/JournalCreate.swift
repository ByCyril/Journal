//
//  JournalCreate.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

class JournalCreate: JournalAction {
    
    private var newJournal: Journal
    
    init(_ title: String,_ content: String) {
        newJournal = Journal(title, content)
    }
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        
        if journals.isEmpty {
            journals.append(newJournal)
            titleReference.insert(newJournal.title)
            return .save
        }
        
        if titleReference.contains(newJournal.title) {
            let newTitle = rename(newJournal.title, titleReference)
            newJournal.title = newTitle
        }
        
        journals.append(newJournal)
        titleReference.insert(newJournal.title)
      
        return .save
    }
    
    func rename(_ title: String,_ titleReference: Set<String>) -> String {
        if titleReference.contains(title) == false {
            return title
        }
        
        let components: [String] = title.components(separatedBy: "-")
        
        if components.count == 1 {
            return rename(title + "-1", titleReference)
        }
        
        let base: String = components.first ?? ""
        let count: Int = Int(components.last ?? "0")! + 1
        
        return rename(base + "-\(count)", titleReference)
    }
    
}
