//
//  JournalApp+Search.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    
    struct Search: ParsableCommand {
        @Argument(help: "Keyword to search") var keyword: String
        
        func run() throws {
            let action = JournalSearch(keyword)
            let res = manager.execute(action)
            
            process(res)
        }
    }
    
}
