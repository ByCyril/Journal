//
//  main.swift
//  Journal
//
//  Created by Cyril Garcia on 6/4/21.
//

import Foundation

import ArgumentParser

struct JournalApp: ParsableCommand {
    
    static var configuration: CommandConfiguration = CommandConfiguration(commandName: "Command Name",
                                                                          abstract: "Abstract",
                                                                          discussion: "Discussion",
                                                                          version: "Version",
                                                                          shouldDisplay: true,
                                                                          subcommands: [Create.self, Delete.self, List.self])
    
    static let journalManager: JournalManager = JournalManager()
    
    mutating func run() throws {}

    static func process(_ result: Result<String, Error>) {
        switch result {
        case .success(let message):
            print("🎉", message)
        case .failure(let error):
            print("🚨", error.localizedDescription)
        }
    }
}

extension JournalApp {
    struct Create: ParsableCommand {
        @Argument(help: "Title of Journal") var title: String
        
        @Option(name: .long, help: "Title of Entry") var entryTitle: String
        @Option(name: .long, help: "Content of Entry") var content: String
        
        func run() throws {
            
            let action = JournalCreate(journalTitle: title, entityTitle: entryTitle, content: content)
            let result = journalManager.execute(action)
            process(result)
        }
    }
}

extension JournalApp {
    struct Delete: ParsableCommand {
        @Option(name: .long, help: "Delete Journal by Title") var journal: String?
        @Option(name: .long, help: "Delete Entry by Title") var entry: String?
        
        func run() throws {
            if let journal = journal {
                let results = journalManager.execute(JournalDelete(journal: journal))
                process(results)
            } else if let entry = entry {
                let results = journalManager.execute(JournalDelete(entry: entry))
                process(results)
            }
        }
        
    }
}

extension JournalApp {
    struct List: ParsableCommand {
        func run() throws {
            let results = journalManager.execute(JournalList())
            process(results)
        }
    }
}

JournalApp.main()
