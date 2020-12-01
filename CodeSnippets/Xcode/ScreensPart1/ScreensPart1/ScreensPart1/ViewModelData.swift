//
//  DummyData.swift
//  ScreensPart1
//
//  Created by MACBOOK on 17.11.20.
//

import Foundation

//dummy Data
struct lessonModel : Identifiable{
    let id = UUID()
    var time: String
    var lessonName: String
    var room: String
    var lecturer: String
    var type:String
    var addtional:String
    var isBlockLesson:Bool
    var datesForBlocklesson:[lessonDateDuration]
}

struct lessonDateDuration: Identifiable{
    var id = UUID()
    var date:Date
    var durationInMinutes:Int
}
