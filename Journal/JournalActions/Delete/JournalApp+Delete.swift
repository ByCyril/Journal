//
//  JournalApp+Delete.swift
//  Journal
//
//  Created by Cyril Garcia on 6/10/21.
//

import Foundation
import ArgumentParser

extension JournalApp {
    
    struct Delete: ParsableCommand {
        
        @Argument(help: "Index to delete") var index: Int
        
        func run() throws {
            
            print("Are you sure you want to delete this item?")
            let confirmation = getInput().lowercased()
            
            if confirmation == "yes" || confirmation == "y" {
                
                let action = JournalDelete(index)
                
                let res = manager.execute(action)
                
                process(res)
                
            } else {
                print("Deletion Failed.")
            }
            
        }
        
    }
}
