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
    var senderName: String?
    var type: MessageType = .iMessage
    var date: Date?
    var text: String
}

let messageExamples = (
    meSmall: Message(id: UUID(), sender: .me, text: "Hi"),
    meMedium: Message(id: UUID(), sender: .me, text: "Hello, here is a longer message"),
    meLarge: Message(id: UUID(), sender: .me, text: "Here is a really long string. There's a bunch of words in here!"),
    otherSmall: Message(id: UUID(), sender: .me, text: "Hi"),
    otherMedium: Message(id: UUID(), sender: .other, text: "Hello, here is a longer message"),
    otherLarge: Message(id: UUID(), sender: .other, text: "Here is a really long string. There's a bunch of words in here!")
)


