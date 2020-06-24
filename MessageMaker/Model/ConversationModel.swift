//
//  ConversationModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation
import SwiftUI

class Conversation: ObservableObject {
//    @Published var messageGroups = [MessageGroup]()
    var messageGroups: [MessageGroup] {
        Self.buildMessageGroups(from: rawText)
    }
    
    @Published var rawText = "" {
        didSet {
//            messageGroups = Self.buildMessageGroups(from: rawText)
        }
    }
    
    init(rawText: String) {
        self.rawText = rawText
//        self.messageGroups = Self.buildMessageGroups(from: rawText)
    }
        
    static func buildMessageGroups(from rawText: String) -> [MessageGroup] {
        var messageGroups = [MessageGroup]()
        var currentMessageGroup = MessageGroup()
        let lines = rawText.components(separatedBy: .newlines)
        var lastSender: Sender = .other
        var currentSender: Sender = .me
        for i in 0..<lines.count {
            let trimmedLine = lines[i].trimmingCharacters(in: .whitespaces)
            if trimmedLine.count > 0 {
                if let timeStamp = TimeStamp(from: lines[i]) {
                    if i == 0 {
                        currentMessageGroup = MessageGroup(timeStampHeader: timeStamp, messages: [])
                    } else {
                        if lines[i - 1].trimmingCharacters(in: .whitespaces).count == 0 {
                            messageGroups.append(currentMessageGroup)
                            currentMessageGroup = MessageGroup(timeStampHeader: timeStamp, messages: [])
                        } else {
                            try? currentMessageGroup.timeStampLastMessage(timeStamp)
                        }
                    }
                } else {
                    let message = Message(
                        id: UUID(),
                        sender: currentSender,
                        text: Self.removingTimeCode(from: lines[i])
                    )
                    currentMessageGroup.messages.append(message)
                    
                    lastSender = currentSender
                }
            } else {
                if lastSender == currentSender {
                    currentSender.toggle()
                }
            }
        }
        if !currentMessageGroup.isEmpty {
            messageGroups.append(currentMessageGroup)
        }
        return messageGroups
    }
    
//    init(oneMessage text: String, sender: Sender) {
//        messages = [Message(id: UUID(), sender: sender, text: text)]
//    }
    
    static let timeRegex = try! NSRegularExpression(pattern: #"\(.+\)"#)
        
    static func removingTimeCode(from text: String) -> String {
        let range = NSRange(location: 0, length: text.utf16.count)
        return Self.timeRegex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "").trimmingCharacters(in: .whitespaces)
    }
    
    static let example = Conversation(rawText: exampleRawText)
}


