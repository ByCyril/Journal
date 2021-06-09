//
//  JournalAction.swift
//  Journal
//
//  Created by Cyril Garcia on 6/6/21.
//

import Foundation

protocol JournalAction {
    func action(with journals: inout [Journal], and titleReference: inout Set<String>) -> JournalTask
}
