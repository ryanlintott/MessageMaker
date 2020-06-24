//
//  MessageModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation

enum Sender {
    case me
    case other
    
    mutating func toggle() {
        switch self {
        case .me:
            self = .other
        case .other:
            self = .me
        }
    }
}

enum MessageType {
    case iMessage
    case sms
}

struct Message: Identifiable {
    var id: UUID
    var sender: Sender
    var type: MessageType = .iMessage
    var text: String
    var timeStamp: TimeStamp?
    
    mutating func addTimeStamp(_ timeStamp: TimeStamp) {
        self.timeStamp = timeStamp
    }
    
    var isBigEmoji: Bool {
        text.count < 6 && text.containsOnlyEmoji
    }
    
    static let examples = (
        meSmall: Message(id: UUID(), sender: .me, text: "Hi"),
        meMedium: Message(id: UUID(), sender: .me, text: "Hello, here is a longer message"),
        meLarge: Message(id: UUID(), sender: .me, text: "Here is a really long string. There's a bunch of words in here!"),
        meEmoji: Message(id: UUID(), sender: .me, text: "😄"),
        otherSmall: Message(id: UUID(), sender: .other, text: "Hi"),
        otherMedium: Message(id: UUID(), sender: .other, text: "Hello, here is a longer message"),
        otherLarge: Message(id: UUID(), sender: .other, text: "Here is a really long string. There's a bunch of words in here!"),
        otherEmoji: Message(id: UUID(), sender: .other, text: "😄☝️")
    )
}

enum MessageGroupError: Error {
    case noMessages
}

struct MessageGroup {
    var timeStampHeader: TimeStamp?
    var messages = [Message]()
    
    var isEmpty: Bool {
        messages.count == 0 && timeStampHeader == nil
    }
    
    mutating func timeStampLastMessage(_ timeStamp: TimeStamp) throws {
        if messages.count > 0 {
            messages[messages.count - 1].addTimeStamp(timeStamp)
        } else {
            throw MessageGroupError.noMessages
        }
    }
    
    static let example = MessageGroup(timeStampHeader: TimeStamp.example, messages: [
        Message.examples.meLarge,
        Message.examples.otherMedium,
        Message.examples.meSmall,
        Message.examples.otherEmoji
    ])
}



