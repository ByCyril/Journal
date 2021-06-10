//
//  JournalError.swift
//  Journal
//
//  Created by Cyril Garcia on 6/7/21.
//

import Foundation

enum JournalError: Error {
    case error(String)
}

extension JournalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .error(let error):
            return error
        }
    }
}
