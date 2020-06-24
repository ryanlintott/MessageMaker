//
//  MessagesView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct MessagesView: View {
    var messages: [Message]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<messages.count) { i in
                MessagesRowView(message: self.messages[i], hasTail: self.applyTail(toIndex: i))
            }
        }
        .padding(.horizontal, 20)
    }
    
    func applyTail(toIndex index: Int) -> Bool {
        if index + 1 < messages.count {
            return messages[index].sender != messages[index + 1].sender
        }
        return true
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(messages: MessageGroup.example.messages)
    }
}
