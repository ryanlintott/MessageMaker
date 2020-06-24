//
//  DateHeaderModel.swift
//  MessageMaker
//
//  Created by Ryan Lintott on 2020-06-23.
//  Copyright © 2020 A Better Way To Do. All rights reserved.
//

import Foundation

struct DateHeader {
    var date: String
    var time: String
    
    init?(from text: String) {
        let dateLine = "--"
        
        if text.hasPrefix(dateLine) && text.hasSuffix(dateLine) {
            let dateLineSet = CharacterSet(charactersIn: dateLine)
            let trimmedText = text
                .trimmingCharacters(in: dateLineSet)
                .trimmingCharacters(in: .whitespaces)
            let components = trimmedText
                .split(separator: ",")
            
            if components.count == 3 {
                self.date = "\(components[0].trimmingCharacters(in: .whitespaces)), \(components[1].trimmingCharacters(in: .whitespaces))"
                self.time = components[2].trimmingCharacters(in: .whitespaces)
            } else {
                self.date = trimmedText
                self.time = ""
            }
        }
        return nil
    }
    
    init(date: String, time: String) {
        self.date = date
        self.time = time
    }
    
    static let example = DateHeader(date: "Sat, May 24,", time: "11:09 AM")
    static let exampleFromRawText = DateHeader(from: "-- Sat, May 24, 11:09 AM --")
}
