//
//  JournalList.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

struct JournalList: JournalAction {
    
    func action(with journals: inout [Journal],
                and titleReference: inout Set<String>) -> JournalTask {
        
        if journals.isEmpty {
            return .error("Journal is currently empty")
        }
        
        list(journals)
        
        return .none
    }
    
    func list(_ journals: [Journal]) {
        print("###########################")
        print("")
        for (i, journal) in journals.enumerated() {
            let heading = "\(i)) ################ " + journal.title + " ################"
            print(heading)
            print(journal.content)
            
            print("")
            print("Date Created:",journal.createdAt.toString())
            let footer = "".padding(toLength: heading.count, withPad: "#", startingAt: 0)
            print(footer)
            print("")
        }
        print("###########################")
    }
}
