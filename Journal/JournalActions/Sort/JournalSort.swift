//
//  JournalSort.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation

struct JournalSort: JournalAction {
    
    enum SortType {
        case title
        case dateCreated
        case lastUpdated
        case contentSize
    }
    
    private let sortType: SortType
    private var ascending: Bool
    
    init(_ sortType: SortType,_ ascending: Bool = true) {
        self.sortType = sortType
        self.ascending = ascending
    }
    
    func action(with journals: inout [Journal],
                and titleReference: inout Set<String>) -> JournalTask {
        
        if journals.isEmpty {
            return .error("Journal is empty.")
        }
        
        journals.sort { sort($0,$1) }
        
        return .writeToJSON
    }
    
    func sort(_ A: Journal,_ B: Journal) -> Bool {
        switch sortType {
        case .title:
            return ascending ? (A.title > B.title) : (A.title < B.title)
        case .dateCreated:
            return ascending ? (A.createdAt < B.createdAt) : (A.createdAt > B.createdAt)
        case .lastUpdated:
            return ascending ? (A.lastUpdated < B.lastUpdated) : (A.lastUpdated > B.lastUpdated)
        case .contentSize:
            return ascending ? (A.content.count < B.content.count) : (A.content.count > B.content.count)
        }
    }
}
