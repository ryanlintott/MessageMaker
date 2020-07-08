//
//  ConversationModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation
import SwiftUI

struct Conversation: Codable, RawRepresentable, Identifiable {
    typealias RawValue = String
    
    let id = UUID()
    var name: String
    var messageGroups: [MessageGroup]
    
    init?(rawValue: RawValue) {
        let lines = rawValue.components(separatedBy: .newlines)
        var messageGroups = [MessageGroup]()
        var currentMessageGroup = MessageGroup()
        var currentSender: Sender = .me
        
        guard let firstLine = lines.first else { return nil }
        let name = firstLine.trimmingCharacters(in: .whitespaces)
        guard name.count > 0 else { return nil }
        self.name = name
        
        for (index, line) in lines.enumerated() {
            // skip first line
            guard index > 0 else { continue }
            
            // Blank line
            guard line.trimmingCharacters(in: .whitespaces).count > 0 else {
                // if following line is timestamp
                if index + 1 < lines.count && TimeStamp(rawValue: lines[index + 1]) != nil {
                    if !currentMessageGroup.isEmpty {
                        messageGroups.append(currentMessageGroup)
                        currentMessageGroup = MessageGroup()
                    }
                } else {
                    currentSender.toggle()
                }
                continue
            }
            
            if let timeStamp = TimeStamp(rawValue: line) {
                if currentMessageGroup.isEmpty {
                    currentMessageGroup.timeStampHeader = timeStamp
                } else {
                    try? currentMessageGroup.timeStampLastMessage(timeStamp)
                }
            } else {
                let message = Message(
                    sender: currentSender,
                    text: line
                )
                currentMessageGroup.messages.append(message)
            }
        }
        if !currentMessageGroup.isEmpty {
            messageGroups.append(currentMessageGroup)
        }
        self.messageGroups = messageGroups
    }
    
    var rawValue: RawValue {
        var rawConversationArray = [name]
        for messageGroup in messageGroups {
            var rawMessageGroupArray = [String]()
            
            if let timeStamp = messageGroup.timeStampHeader {
                rawMessageGroupArray.append(timeStamp.rawValue)
            } else {
                rawMessageGroupArray.append("----")
            }
            
            var currentSender: Sender = .me
            for message in messageGroup.messages {
                if message.sender != currentSender {
                    rawMessageGroupArray.append("")
                    currentSender.toggle()
                }
                rawMessageGroupArray.append(message.rawValue)
            }
            rawConversationArray.append(rawMessageGroupArray.joined(separator: .newLine))
        }
        return rawConversationArray.joined(separator: .newLine)
    }
    
    static let timeRegex = try! NSRegularExpression(pattern: #"\(.+\)"#)
        
    static func removingTimeCode(from text: String) -> String {
        let range = NSRange(location: 0, length: text.utf16.count)
        return Self.timeRegex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "").trimmingCharacters(in: .whitespaces)
    }
    
    static let example = Conversation(rawValue: exampleRawText)!
    static let exampleLong = Conversation(rawValue: exampleRawTextLong)!
}


