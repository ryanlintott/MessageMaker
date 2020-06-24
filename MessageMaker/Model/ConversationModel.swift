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
    @Published var messageGroups = [MessageGroup]()
    
    static let timeRegex = try! NSRegularExpression(pattern: #"\(.+\)"#)
    
    
    init(rawText: String) {
        var messageGroups = [MessageGroup]()
        var currentMessageGroup = MessageGroup()
        let lines = rawText.components(separatedBy: .newlines)
        var lastSender: Sender = .other
        var currentSender: Sender = .me
        for line in lines {
            if line.trimmingCharacters(in: .whitespaces).count > 0 {
                if let dateHeader = DateHeader(from: line) {
                    if !currentMessageGroup.isEmpty {
                        messageGroups.append(currentMessageGroup)
                    }
                    currentMessageGroup = MessageGroup(dateHeader: dateHeader)
                } else {
                    let message = Message(
                        id: UUID(),
                        sender: currentSender,
                        text: Self.removingTimeCode(from: line)
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
        self.messageGroups = messageGroups
    }
    
//    init(oneMessage text: String, sender: Sender) {
//        messages = [Message(id: UUID(), sender: sender, text: text)]
//    }
    
    static func removingTimeCode(from text: String) -> String {
        let range = NSRange(location: 0, length: text.utf16.count)
        return Self.timeRegex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "").trimmingCharacters(in: .whitespaces)
    }
    
    static let example = Conversation(rawText: """
        Help. Stranded in Westchester. (09:48pm)
        Pls put out hit on Tommy for me (09:48pm)

        Why the fuck do you still hang out w that bag of dicks (09:50pm)
        How was the flight? (09:51pm)
         
        Long and the food was so fucking gross (09:52pm)
        --
        Aw no caviar bb? Why tf are you in westchester (09:53pm)

        Tommy has abandoned me at a party to buy drugs. (09:53pm)

        Sounds about right. (09:54pm)
        Any cute girkls (09:56pm)

        Whats a girkl (09:56pm)

        🙄(09:56pm)
        """
    )
}
