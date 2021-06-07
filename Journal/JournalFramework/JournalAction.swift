//
//  JournalAction.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

protocol JournalAction {
    func action(with library: inout [String: Journal]) -> JournalError?
}
