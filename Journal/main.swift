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
                                                                          subcommands: [Create.self])
    
    static let manager: JournalManager = JournalManager()
        
    static func process(_ result: Result<String, Error>) {
        switch result {
        case .failure(let error):
            print("🛑",error.localizedDescription)
        case .success(let message):
            print("🎉",message)
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
