//
//  RawTextView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct EditConversationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var conversation: Conversation
    @State var draftText: String = ""
    
    var firstMessage: String {
        conversation.messageGroups.first?.messages.first?.text ?? "N/A"
    }
    
    var body: some View {
        VStack {
            MultilineTextView(text: $draftText, fontSize: 16)
                .padding(4)
                .border(Color.secondary, width: 1)
                .padding()
        }
        .navigationBarTitle(conversation.name)
        .navigationBarItems(leading: Button("Cancel") {
                self.cancel()
            }, trailing: Button("Save") {
                self.save()
            }
        )
        .onAppear(perform: createDraft)
    }
    
    func createDraft() {
        draftText = conversation.rawValue
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func save() {
        if let conversation = Conversation(rawValue: draftText) {
            self.conversation = conversation
        } else {
            print("error saving conversation")
            // error saving conversation
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct RawTextView_Previews: PreviewProvider {
    struct PreviewData: View {
        @State private var conversation = Conversation.example
        
        var body: some View {
            EditConversationView(conversation: $conversation)
        }
    }
        
    static var previews: some View {
        NavigationView {
            PreviewData()
        }
    }
}


