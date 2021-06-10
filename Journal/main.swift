//
//  main.swift
//  Journal
//
//  Created by Cyril Garcia on 6/4/21.
//

import Foundation

import ArgumentParser

struct JournalApp: ParsableCommand {
    
    static var configuration: CommandConfiguration = CommandConfiguration(commandName: "Journal",
                                                                          shouldDisplay: true,
                                                                          subcommands: [])
    
    static let manager: JournalManager = JournalManager()
    
    @Option(name: .long, help: "Contents of new journal entry") var create: String?
    @Option(name: .long, help: "Title of entry") var title: String?
    
    @Flag(name: .long, help: "List all journal entries") var list: Bool = false
    
    func run() throws {
        
        listItems()
        createJournal()
    }
    
    func createJournal() {
        guard let title = title, let create = create else { return }
        let action = JournalCreate(title, create)
        let result = JournalApp.manager.execute(action)
        JournalApp.process(result)
    }
    
    func listItems() {
        if !list { return }
        
        let action = JournalList()
        let result = JournalApp.manager.execute(action)
        JournalApp.process(result)
    }
        
    static func process(_ result: Result<Any?, Error>) {
        switch result {
        case .failure(let error):
            print("🛑", error.localizedDescription)
        case .success(let message):
            print("🎉", message as? String ?? "")
        }
    }
    
    static func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: String.Encoding.utf8)!
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }

}

JournalApp.main()
