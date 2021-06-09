//
//  JournalManager.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

class JournalManager {
    
    let filePath: URL
    
    private(set) var journals: [Journal] = []
    private(set) var journalTitleReference: Set<String> = []
    
    init(_ filePath: URL = URL(fileURLWithPath: "/Users/cy/Desktop/Journal/Journal/Library.json"),
         _ journals: [Journal] = []) {
        self.filePath = filePath
        self.journals = journals
        readFromJSON()
    }
    
    func readFromJSON() {
        
        guard let data = try? Data(contentsOf: filePath) else { return }
        
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        decode.dataDecodingStrategy = .base64
        
        do {
            journals = try decode.decode([Journal].self, from: data)
            
            for journal in journals {
                journalTitleReference.insert(journal.title)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func writeToJSON() -> Result<Any?, JournalError> {
        let encoder: JSONEncoder = JSONEncoder()
    
        do {
            let data = try encoder.encode(journals)
            try data.write(to: filePath)
            return .success("Success!")
        } catch {
            return .failure(JournalError.error(error.localizedDescription))
        }
    }
    
    func execute(_ action: JournalAction) -> Result<Any?, JournalError> {
        let task = action.action(with: &journals, and: &journalTitleReference)
        
        switch task {
        case .error(let errorMessage):
            return .failure(JournalError.error(errorMessage))
        case .writeToJSON:
            return writeToJSON()
        case .none:
            return .success(nil)
        }
        
    }
    
}
