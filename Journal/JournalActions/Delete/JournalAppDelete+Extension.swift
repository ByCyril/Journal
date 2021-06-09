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
        @Argument(help: "Title of entry to delete") var title: String
        
        func run() throws {
            let action = JournalDelete(title)
            let result = manager.execute(action)
            process(result)
        }
    }
}
