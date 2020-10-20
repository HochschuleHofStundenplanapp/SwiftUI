//
//  ChangedLecture.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import Foundation

struct ChangedLecture: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case docent = "docent"
        case comment = "commentKey"
        case oldTime = "oldTime"
        case oldDate = "oldDate"
        case oldDay = "oldDay"
        case oldRoom = "oldRoom"
        case newTime = "newTime"
        case newDate = "newDate"
        case newDay = "newDay"
        case newRoom = "newRoom"
        case group = "group"
        case splusname = "splusname"
    }
    
    var id: Int
    var name: String
    var docent: String
    var comment: String
    var oldTime: Date
    var oldDate: Date
    var oldDay: String
    var oldRoom: String
    var newTime: Date?
    var newDate: Date?
    var newDay: String
    var newRoom: String
    var group: String
    var splusname : String
    
    //Inserting course of studies
    init(id: Int, name: String, docent: String, comment: String,
         oldTime: Date, oldDate: Date, oldDay: String, oldRoom: String,
         newTime: Date?, newDate: Date?, newDay: String, newRoom: String,  group: String, splusname : String) {
        self.id = id
        self.name = name
        self.docent = docent
        self.comment = comment
        self.oldTime = oldTime
        self.oldDate = oldDate
        self.oldDay = oldDay
        self.oldRoom = oldRoom
        self.newTime = newTime
        self.newDate = newDate
        self.newDay = newDay
        self.newRoom = newRoom
        self.group = group
        self.splusname = splusname
        
    }
    
    var combinedOldDate: Date {
        get {
            let calendar = Calendar.current
            
            let day = calendar.component(.day, from: oldDate)
            let month = calendar.component(.month, from: oldDate)
            let year = calendar.component(.year, from: oldDate)
            
            let hour = calendar.component(.hour, from: oldTime)
            let minutes = calendar.component(.minute, from: oldTime)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy HH:mm"
            dateFormatter.locale = Locale(identifier: "de_DE")
            
            let end = dateFormatter.date(from:"\(day).\(month).\(year) \(hour):\(minutes)")
            
            return end!
        }
    }
    
    var combinedNewDate: Date! {
        get {
            let calendar = Calendar.current
            var end : Date? = nil
            
            if (newDate != nil) {
                let day = calendar.component(.day, from: newDate!)
                let month = calendar.component(.month, from: newDate!)
                let year = calendar.component(.year, from: newDate!)
                
                let hour = calendar.component(.hour, from: newTime!)
                let minutes = calendar.component(.minute, from: newTime!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy HH:mm"
                dateFormatter.locale = Locale(identifier: "de_DE")
                
                end = dateFormatter.date(from:"\(day).\(month).\(year) \(hour):\(minutes)")! as Date?
            }
            
            return end
        }
    }
}
