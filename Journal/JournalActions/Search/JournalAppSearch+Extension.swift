//
//  JournalAppSearch+Extension.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    struct Search: ParsableCommand {
        @Option(name: .long, help: "Search entries by Title") var title: String?
        @Option(name: .long, help: "Search entries by Keyword") var keyword: String?
        
        func run() throws {
            let action = JournalSearch(title: title)
            let result = manager.execute(action)
            process(result)
        }
    }
}
