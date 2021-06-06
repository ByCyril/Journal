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
    
    private(set) var journals: [Journal]
    
    init(_ url: URL = URL(fileURLWithPath: "/Users/cy/Desktop/Journal/Journal/Journal.json"),
         _ journals: [Journal] = []) {
        self.filePath = url
        self.journals = journals
        fetch()
    }
    
    func fetch() {
        
        guard let data = try? Data(contentsOf: filePath) else { return }
        
        let decode = JSONDecoder()
        
        do {
            journals = try decode.decode([Journal].self, from: data)
        } catch {
            print("Error here",error.localizedDescription)
        }
    }
    
    func execute(_ action: JournalAction) -> Result<String, Error> {
        action.action(with: &journals, with: filePath)
        return action.execute(journals)
    }
    
}
