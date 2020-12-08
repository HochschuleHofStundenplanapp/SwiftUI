//
//  DummyData.swift
//  ScreensPart1
//
//  Created by MACBOOK on 17.11.20.
//

import Foundation

/// A lecture Model suitable for display
struct lessonModel : Identifiable{
    let id:String
    var starttime: String
    var endtime: String
    var lessonName: String
    var room: String
    var lecturer: String
    var type:String
    var addtional:String
    ///the day of the week encoded as 0:Monday to 6:Sunday
    var day:String
    var isBlockLesson:Bool
    var datesForBlocklesson:[lessonDateDuration]
}

///The time and duration data probably coming from the backend
struct lessonDateDuration: Identifiable{
    var id = UUID()
    var date:Date
    var durationInMinutes:Int
}
