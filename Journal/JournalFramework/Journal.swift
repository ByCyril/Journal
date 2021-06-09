//
//  Journal.swift
//  Journal
//
//  Created by Cyril Garcia on 6/4/21.
//

import Foundation

protocol Entity: Codable {
    var title: String { get set }
    var createdAt: Date { get set }
    var lastUpdated: Date { get set }
}

struct Journal: Entity {
    
    var createdAt: Date = Date()
    var lastUpdated: Date = Date()
    
    var title: String {
        didSet {
            lastUpdated = Date()
        }
    }
    
    var content: String {
        didSet {
            lastUpdated = Date()
        }
    }
    
    init(_ title: String, _ content: String) {
        self.title = title
        self.content = content
    }
}
