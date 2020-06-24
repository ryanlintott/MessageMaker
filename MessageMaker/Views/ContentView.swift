//
//  ContentView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-13.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var conversation = Conversation.example
    @State private var showingEditView = false
    
    var body: some View {
        Group {
            ConversationView(conversation: conversation)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.showingEditView.toggle()
                }
        }
        .sheet(isPresented: $showingEditView) {
            RawTextView(text: self.$conversation.rawText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
