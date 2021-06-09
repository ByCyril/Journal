//
//  JournalList.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

struct JournalList: JournalAction {
    
    func action(with journals: inout [Journal],
                and titleReference: inout Set<String>) -> JournalError? {
        
        if journals.isEmpty {
            return .isEmpty("Journal is currently empty")
        }
        
        listByTitle(journals)
        
        return nil
    }
    
    func listByTitle(_ journals: [Journal]) {
        print("###########################")
        print("")
        for journal in journals {
            print(journal.title)
            print(journal.content)
            print("")
        }
        print("###########################")
    }
}
