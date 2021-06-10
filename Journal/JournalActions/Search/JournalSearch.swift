//
//  JournalSearch.swift
//  Journal
//
//  Created by Cyril Garcia on 6/9/21.
//

import Foundation

final class JournalSearch: JournalAction {
    
    private let keyword: String
    
    init(_ keyword: String) {
        self.keyword = keyword
    }
    
    private var results: [Journal] = []
    var ref = Set<String>()
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        
        for journal in journals {
            let titleArray = Set(journal.title.components(separatedBy: " "))
            let contentArray = Set(journal.content.components(separatedBy: " "))
            
            if titleArray.contains(keyword) || contentArray.contains(keyword) {
                results.append(journal)
            }
        }
            
        return JournalList().action(with: &results, and: &ref)
    }
}
