//
//  JournalManager.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

struct JournalError: Error {
    var localizedDescription: String
}

final class JournalManager {
    
    private let filePath: URL
    
    private(set) var journals: [String: Journal] = [:]
    
    init(_ url: URL = URL(fileURLWithPath: "/Users/cy/Desktop/Journal/Journal/Journal.json"),
         _ journals: [String: Journal] = [:]) {
        self.filePath = url
        self.journals = journals
        fetch()
    }
    
    func fetch() {
        
        guard let data = try? Data(contentsOf: filePath) else { return }
        
        let decode = JSONDecoder()
        
        do {
            let fetchedJournals = try decode.decode([Journal].self, from: data)
            
            for journal in fetchedJournals {
                journals[journal.title] = journal
            }
            
        } catch {
            print("Error here",error.localizedDescription)
        }
    }
    
    func execute(_ action: JournalAction) -> Result<String, Error> {
        action.action(with: &journals, with: filePath)
        return action.execute(journals)
    }
    
}
