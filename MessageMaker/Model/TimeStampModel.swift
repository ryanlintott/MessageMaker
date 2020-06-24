//
//  TimeStampModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation

struct TimeStamp {
    var label: String?
    var time: String
    
    init?(from text: String) {
        let dateLine = "--"
        
        if text.hasPrefix(dateLine) && text.hasSuffix(dateLine) {
            let dateLineSet = CharacterSet(charactersIn: "-")
            let trimmedText = text
                .trimmingCharacters(in: dateLineSet)
                .trimmingCharacters(in: .whitespaces)
            if trimmedText.count > 0 {
                let components = trimmedText.split(separator: "|")
                
                if components.count > 1 {
                    self.label = String(components[0])
                    self.time = String(components[1])
                } else {
                    self.time = trimmedText
                }
                return
            }
        }
        return nil
    }
    
    init(label: String? = nil, time: String) {
        self.label = label
        self.time = time
    }
    
    static let example = TimeStamp(label: "Sat, May 24,", time: "11:09 AM")
    static let exampleFromRawText = TimeStamp(from: "-- Sat, May 24,| 12:00 PM --")
}
