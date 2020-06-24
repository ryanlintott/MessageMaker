//
//  ConversationView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    var conversation: Conversation
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<conversation.messageGroups.count) { i in
                MessageGroupView(messageGroup: self.conversation.messageGroups[i])
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("iphone11_messages_screenshot")
                .offset(x: 0, y: 39)
//                .offset(x: 290, y: 325) // Emoji offset
                .opacity(0.0)
                .edgesIgnoringSafeArea(.all)
            
            ConversationView(conversation: Conversation.example)
        }
    }
}
