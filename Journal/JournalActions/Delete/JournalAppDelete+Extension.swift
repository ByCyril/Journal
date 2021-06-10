//
//  JournalAppDelete+Extension.swift
//  Journal
//
//  Created by Cyril Garcia on 6/8/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    struct Delete: ParsableCommand {
        @Option(help: "Title of entry to delete") var title: String?
        @Flag(help: "Title of entry to delete") var all: Bool = false
        
        func run() throws {
            
            if all {
                let action = JournalDelete(.all)
                let results = manager.execute(action)
                process(results)
                return
            }
            
            if let title = title {
                let action = JournalDelete(.title(title))
                let results = manager.execute(action)
                process(results)
                return
            }
            
        }
    }
}
