//
//  MessagesRowView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-13.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI



struct MessagesRowView: View {
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
        .padding(.bottom, hasTail ? 8 : 1)
        .padding(.leading, textOnLeft ? 0 : farPadding)
        .padding(.trailing, textOnLeft ? farPadding : 0)
    }
}

extension MessagesRowView {
    init(message: Message, hasTail: Bool = true) {
        self.message = message.text
        self.hasTail = hasTail
        self.farPadding = 89
        
        switch message.sender {
        case .me:
            self.alignment = .trailing
            self.textColor = .white
            self.backgroundColor = message.type == .sms ? .green : .blue
        case .other:
            self.alignment = .leading
            self.textColor = .black
            self.backgroundColor = .init(red: 233/255, green: 233/255, blue: 234/255)
        }
    }
}

struct MessagesRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessagesRowView(message: messageExamples.meSmall)
                .previewLayout(.sizeThatFits)
                .padding()
            
            MessagesRowView(message: messageExamples.otherMedium)
                .previewLayout(.sizeThatFits)
                .padding()
            
            MessagesRowView(message: messageExamples.meMedium, hasTail: false)
                .previewLayout(.sizeThatFits)
                .padding()
            
            MessagesRowView(message: messageExamples.meLarge)
                .previewLayout(.sizeThatFits)
                .padding()
        }
            
    }
}
