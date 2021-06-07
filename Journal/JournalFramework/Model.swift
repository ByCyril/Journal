//
//  Model.swift
//  Journal
//
//  Created by Cyril Garcia on 6/4/21.
//

import Foundation

protocol Entity: Codable {
    var id: UUID { get set }
    var title: String { get set }
    var createdAt: Date { get set }
}

class Journal: Entity {
    var id: UUID = UUID()
    var title: String
    
    var entries: [String: Entry] = [:] {
        didSet {
            updatedAt = Date()
        }
    }
    
    var createdAt: Date = Date()
    var updatedAt: Date
    
    init(_ title: String) {
        self.title = title
        self.updatedAt = createdAt
    }
}

struct Entry: Entity, Equatable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: Date = Date()
}
