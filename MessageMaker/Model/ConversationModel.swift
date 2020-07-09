//
//  ConversationModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation
import SwiftUI

struct Conversation: Codable, Identifiable {
    let id = UUID()
    var name: String
    var messageGroups: MessageGroups
    
    init(name: String, messageGroups: MessageGroups = []) {
        self.name = name
        self.messageGroups = messageGroups
    }
    
    static let example = Conversation(name: "Example", messageGroups: MessageGroups(rawValue: exampleRawText)!)
    static let exampleLong = Conversation(name: "Long Example", messageGroups: MessageGroups(rawValue: exampleRawTextLong)!)
}


