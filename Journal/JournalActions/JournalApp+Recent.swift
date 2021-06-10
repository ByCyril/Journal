//
//  JournalApp+Recent.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    
    struct Recent: ParsableCommand {
        @Argument(help: "Days ago") var days: Int
        
        func run() throws {
            
            let action = JournalRecent(days)
            
            let res = manager.execute(action)
            
            process(res)
        }
    }
}
