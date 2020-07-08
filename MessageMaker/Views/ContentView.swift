//
//  ContentView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-13.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var conversationData = ConversationData(conversations: [Conversation(rawValue: exampleRawText)!])
    
    var body: some View {
        NavigationView {
            ConversationsView(conversations: $conversationData.conversations)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
