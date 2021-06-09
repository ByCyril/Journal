//
//  JournalSearch.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation

final class JournalSearch: JournalAction {
    
    private var title: String?
    private var keyword: String?
    
    init(title: String?) {
        self.title = title
    }
    
    init(keyword: String?) {
        self.keyword = keyword
    }
    
    func action(with journals: inout [Journal],
                and titleReference: inout Set<String>) -> JournalError? {
        
        if journals.isEmpty {
            return .isEmpty("Journal is Empty")
        }
        
        if let title = title {
            let filteredJournals = journals.filter { journal in
                Set(journal.title.components(separatedBy: " ")).contains(title)
            }
            list(filteredJournals)
            return nil
        }
        
        return nil
    }
    
    func list(_ journals: [Journal]) {
        print("########################")
        print("")
        
        journals.forEach { journal in
            print(journal.title)
            print(journal.content)
            print("")
        }
        
        print("########################")
    }
    
}
