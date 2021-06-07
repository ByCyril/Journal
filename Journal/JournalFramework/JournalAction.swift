//
//  JournalAction.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

protocol JournalAction {
    var url: URL? { get set }
    
    func action(with journals: inout [String: Journal], with url: URL) 
    func execute(_ journals: [String: Journal]) -> Result<String, Error>
}

extension JournalAction {
    func execute(_ journals: [String: Journal]) -> Result<String, Error> {
        guard let url = url else { return .failure(JournalError(localizedDescription: "URL is nil"))}
        let encoder: JSONEncoder = JSONEncoder()
        do {
            let data = try encoder.encode(journals)
            try data.write(to: url)
            return .success("Success!")
        } catch {
            return .failure(error)
        }
    }
}
