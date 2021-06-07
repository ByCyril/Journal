//
//  JournalManager.swift
//  Journal
//
//  Created by Cyril Garcia on 6/5/21.
//

import Foundation

enum JournalError: Error {
    case isEmpty(String? = nil)
    case couldNotFindEntry(String)
    case couldNotFindJournal(String)
    case error(String)
    
    var message: String {
        switch self {
        case .couldNotFindEntry(let title):
            return "Could not find '\(title)' in this journal."
        case .couldNotFindJournal(let title):
            return "Could not find '\(title)' in your library."
        case .error(let error):
            return error
        case .isEmpty(let message):
            return message ?? "Empty"
        }
    }
}

class JournalManager {
    
    let filePath: URL
    
    private(set) var library: [String: Journal]
    
    init(_ filePath: URL = URL(fileURLWithPath: "/Users/cy/Desktop/Journal/Journal/Library.json"),
         _ library: [String: Journal] = [:]) {
        self.filePath = filePath
        self.library = library
        readFromJSON()
    }
    
    func readFromJSON() {
        
        guard let data = try? Data(contentsOf: filePath) else { return }
        
        let decode = JSONDecoder()
        decode.keyDecodingStrategy = .convertFromSnakeCase
        decode.dataDecodingStrategy = .base64
        
        do {
            library = try decode.decode([String: Journal].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func writeToJSON() -> Result<Any?, JournalError> {
        let encoder: JSONEncoder = JSONEncoder()
    
        do {
            let data = try encoder.encode(library)
            try data.write(to: filePath)
            return .success("Success!")
        } catch {
            return .failure(JournalError.error(error.localizedDescription))
        }
    }
    
    func execute(_ action: JournalAction) -> Result<Any?, JournalError> {
        if let error = action.action(with: &library) {
            return .failure(error)
        } else {
            return writeToJSON()
        }
    }
    
}
