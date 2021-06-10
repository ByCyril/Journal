//
//  JournalSearch.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation

final class JournalSearch: JournalAction {
    
    private let keyword: String
    private(set) var searchResults: [Journal] = []
    
    init(_ keyword: String) {
        self.keyword = keyword.lowercased()
    }
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
       
        searchResults = journals.filter {
            $0.title.lowercased().contains(keyword) || $0.content.lowercased().contains(keyword)
        }
        
        JournalList().list(searchResults)
        
        return .none
    }
    
}
