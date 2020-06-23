//
//  RawTextView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI

struct RawTextView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var text: String
    @State var draftText: String = ""
    
    var body: some View {
        VStack {
            MultilineTextView(text: $draftText)
                .font(.headline)
                .padding()
        }
        .navigationBarTitle("Raw Text")
        .navigationBarItems(leading: Button("Cancel") {
                self.cancel()
            }, trailing: Button("Save") {
                self.save()
            }
        )
        .onAppear(perform: createDraft)
    }
    
    func createDraft() {
        draftText = text
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func save() {
        text = draftText
        presentationMode.wrappedValue.dismiss()
    }
}

struct RawTextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RawTextView(text: .constant("""
                Here is a long string that will take up several lines.
                one
                two
                three

                and even more

                --- break ---

                and more
                """
            ))
        }
    }
}


