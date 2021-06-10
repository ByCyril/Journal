//
//  JournalRecent.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation

final class JournalRecent: JournalAction {
    
    private let days: Int
    
    init(_ days: Int) {
        self.days = days
    }
    
    var results: [Journal] = []
    
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask {
        
        if days <= -1 {
            return .error("Invalid Input")
        }
        
        results = journals.filter {
            let lowerBound = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
            
            return (lowerBound...Date()).contains($0.createdAt)
        }
        
        JournalList().list(results)
        
        return .none
    }
}
