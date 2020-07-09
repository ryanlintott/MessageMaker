//
//  ConversationView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    @Binding var conversation: Conversation
    @State private var showingEditView = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(0..<conversation.messageGroups.count, id: \.self) { i in
                    MessageGroupView(messageGroup: self.conversation.messageGroups[i])
                }
                
                NavigationLink(
                    destination: EditConversationView(conversation: self.$conversation),
                    isActive: $showingEditView
                ) {
                    EmptyView()
                }.isDetailLink(false)
            }
        }
        .navigationBarTitle(Text(conversation.name), displayMode: .inline)
        .navigationBarItems(trailing:
            Button("Edit") {
                self.showingEditView = true
            }
        )
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            ZStack {
//                Image("iphone11_messages_screenshot")
//                    .offset(x: 0, y: 39)
//    //                .offset(x: 290, y: 325) // Emoji offset
//                    .opacity(0.0)
//                    .edgesIgnoringSafeArea(.all)
//
            ConversationView(conversation: .constant(Conversation.exampleLong))
        }
    }
}
