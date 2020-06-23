//
//  ConversationView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var conversation = Conversation(rawText: sampleConversationText)
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<conversation.messages.count) { i in
                MessagesRowView(message: self.conversation.messages[i], hasTail: self.applyTail(toIndex: i))
            }
            Spacer()
            Text("Message Count: \(conversation.messages.count)")
        }
        .padding(20)
    }
    
    func applyTail(toIndex index: Int) -> Bool {
        if index + 1 < conversation.messages.count {
            return conversation.messages[index].sender != conversation.messages[index + 1].sender
        }
        return true
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("iphone11_messages_screenshot")
                .offset(x: 0, y: 39)
                .opacity(0.0)
                .edgesIgnoringSafeArea(.all)
            
            ConversationView()
        }
    }
}
