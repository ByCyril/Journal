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
            print("Error here",error.localizedDescription)
        }
    }
    
    func writeToJSON() -> Result<Any?, Error> {
        let encoder: JSONEncoder = JSONEncoder()
    
        do {
            let data = try encoder.encode(library)
            try data.write(to: filePath)
            return .success("Success!")
        } catch {
            return .failure(error)
        }
    }
    
    func execute(_ action: JournalAction) -> Result<Any?, Error> {
        if let error = action.action(with: &library) {
            return .failure(error)
        } else {
            return writeToJSON()
        }
    }
    
}
