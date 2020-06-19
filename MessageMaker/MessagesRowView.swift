//
//  MessagesRowView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-13.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

enum Sender {
    case me(sms: Bool)
    case other
}

enum MessageType {
    case iMessage
    case sms
}

struct MessagesRowView: View {
    let sender: Sender
    let message: String
    let alignment: HorizontalAlignment
    let hasTail: Bool
    let textColor: Color
    let backgroundColor: Color
    let farPadding: CGFloat
    var textOnLeft: Bool {
        alignment == .leading
    }
    
    var body: some View {
        HStack {
            textOnLeft ? nil : Spacer()
            
            TextBubbleView(message: message, messageAlignment: alignment, textColor: textColor, backgroundColor: backgroundColor, hasTail: hasTail)

            textOnLeft == false ? nil : Spacer()
        }
        .padding(.top, 1)
        .padding(.bottom, hasTail ? 4 : 1)
        .padding(.leading, textOnLeft ? 0 : farPadding)
        .padding(.trailing, textOnLeft ? farPadding : 0)
    }
}

extension MessagesRowView {
    init(sender: Sender, message: String, hasTail: Bool = true) {
        self.sender = sender
        self.message = message
        self.hasTail = hasTail
        self.farPadding = 89
        
        switch sender {
        case .me(let sms):
            self.alignment = .trailing
            self.textColor = .white
            self.backgroundColor = sms ? .green : .blue
        case .other:
            self.alignment = .leading
            self.textColor = .black
            self.backgroundColor = .init(red: 233/255, green: 233/255, blue: 234/255)
        }
    }
}

struct MessagesRowView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesRowView(sender: .me(sms: false), message: "Hi")
    }
}
