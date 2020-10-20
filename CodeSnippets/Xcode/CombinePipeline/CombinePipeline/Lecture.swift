//
//  Lecture.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct Lecture: Codable, Equatable {

    var key: String //splusname+semester+lecture
    var id: Int
    var splusname: String
    var name: String
    var lecturer: String
    var type: String
    var style: String
    var group: String
    var startdate: Date
    var enddate: Date
    var day: String
    var room: String
    var calendarName : String
    var semester: Semester
    var comment : String
    var iteration : iterationState
    var kwDates : [Date]
    
    enum CodingKeys: String, CodingKey{
        case calendarName = "calendarKey"
        case key = "lectureKey"
        case id = "lectureId"
        case splusname = "lectureSplusname"
        case name = "lectureName"
        case lecturer = "lectureLecturer"
        case style = "lectureStyle"
        case type = "lectureType"
        case group = "lectureGroup"
        case startdate = "lectureStartdate"
        case enddate = "lectureEnddate"
        case day = "lectureDay"
        case room = "lectureRoom"
        //case selectedKey = "lectureSelected" //Idk what this is supposed to do. It has no corresponding variable
        case semester = "lectureSemester"
        case comment = "lectureComment"
        case iteration = "lectureIteration"
        case kwDates = "kwDates"
    }
    
    init(id: Int, splusname: String,name: String, lecturer: String, type: String, style: String, group: String, startdate: Date, enddate: Date, day: String, room: String, semester: Semester, comment : String, iteration: iterationState, kwDates: [Date],calendarName : String) {
        self.key = splusname + semester.name + semester.course.contraction
        self.id = id
        self.splusname = splusname
        self.name = name
        self.lecturer = lecturer
        self.type = type
        self.style = style
        self.group = group
        self.startdate = startdate
        self.enddate = enddate
        self.day = day
        self.room = room
        self.semester = semester
        self.comment = comment
        self.iteration = iteration
        self.kwDates = kwDates
        self.calendarName = calendarName
    }
    
    var startTime: Date {
        get {
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: startdate)
            let minutes = calendar.component(.minute, from: startdate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.locale = Locale(identifier: "de_DE")
            let start = dateFormatter.date(from:"\(hour) \(minutes)")
            
            return start!
        }
    }
    
    var endTime: Date {
        get {
            let calendar = Calendar.current
            
            let hour = calendar.component(.hour, from: enddate)
            let minutes = calendar.component(.minute, from: enddate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.locale = Locale(identifier: "de_DE")
            let end = dateFormatter.date(from:"\(hour) \(minutes)")
            
            return end!
        }
    }
}

enum iterationState: Int, Codable{
    case individualDate = 0
    case daily = 1
    case weekly = 7
    case twoWeeks = 14
    case calendarWeeks = -1
    case notParsable = -2
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .individualDate
        case 1:
            self = .daily
        case 7:
            self = .weekly
        case 14:
            self = .twoWeeks
        case -1:
            self = .calendarWeeks
        case -2:
            self = .notParsable
        default:
            return nil
        }
    }
}
