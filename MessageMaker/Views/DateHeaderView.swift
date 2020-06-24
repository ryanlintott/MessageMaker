//
//  DateHeaderView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct DateHeaderView: View {
    @State var dateHeader: DateHeader
    
    var body: some View {
        HStack {
            Text("\(dateHeader.date) ")
                .bold()
            +
            Text(dateHeader.time)
        }
        .font(.system(size: 11))
        .foregroundColor(.secondary)
//        .onAppear {
//            self.dateHeader.date = "Today"
//            self.dateHeader.time = "9:45 AM"
//        }
    }
}

struct DateHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DateHeaderView(dateHeader: DateHeader.example)
            .previewLayout(.sizeThatFits)
    }
}
