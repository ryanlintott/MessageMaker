//
//  DataModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-07-08.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation

class ConversationData: ObservableObject {
    @Published var conversations: [Conversation] {
        didSet {
            save()
        }
    }
    
    private let saveKey = "Conversations"
    
    init(conversations: [Conversation]) {
        self.conversations = conversations
    }
    
    init() {
        self.conversations = UserDefaults.standard.decode([Conversation].self, forKey: saveKey) ?? [.example]
    }
    
    func save() {
        UserDefaults.standard.encode(conversations, forKey: saveKey)
    }
}
