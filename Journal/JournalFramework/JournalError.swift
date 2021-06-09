//
//  JournalError.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

enum JournalError: Error {
    case isEmpty(String? = nil)
    case couldNotFindEntry(String)
    case couldNotFindJournal(String)
    case error(String)
    
    var message: String {
        switch self {
        case .couldNotFindEntry(let title):
            return "Could not find '\(title)' in this journal."
        case .couldNotFindJournal(let title):
            return "Could not find '\(title)' in your library."
        case .error(let error):
            return error
        case .isEmpty(let message):
            return message ?? "Empty"
        }
    }
}
