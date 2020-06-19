//
//  ContentView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-13.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("iphone11_messages_screenshot")
                    .offset(x: 0, y: 39)
                    .opacity(0)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    MessagesRowView(sender: .me(sms: false), message: "Hi Tara")
                    MessagesRowView(sender: .other, message: "Hi, how's things?")
                    MessagesRowView(sender: .me(sms: false), message: "Great! I've finally go these messages to look how they're supposed to!")
                    MessagesRowView(sender: .other, message: "👍")
                    MessagesRowView(sender: .me(sms: false), message: "Yeah, I know...", hasTail: false)
                    MessagesRowView(sender: .me(sms: false), message: "The big emojis aren't working yet", hasTail: false)
                    MessagesRowView(sender: .me(sms: false), message: "But the tails look nice and only appear on the last message of a chain >")
                }
                .padding(20)
                .frame(width: geo.size.width)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
