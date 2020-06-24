//
//  MultilineTextView.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import SwiftUI
import Combine

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextView(text: .constant("""
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
