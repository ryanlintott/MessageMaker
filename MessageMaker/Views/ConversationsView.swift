//
//  ConversationsView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-07-08.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ConversationsView: View {
    @Binding var conversations: [Conversation]
    
    var body: some View {
        List {
            ForEach(0..<conversations.count) { i in
                NavigationLink(destination: ConversationView(conversation: self.$conversations[i])) {
                    Text(self.conversations[i].name)
                }

            }
        }
        .navigationBarTitle("Conversations")
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView(conversations: .constant([.example]))
    }
}
