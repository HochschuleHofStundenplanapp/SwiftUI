//
//  DummyData.swift
//  ScreensPart6
//
//  Created by Xiongwei Zheng on 01.12.20.
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
    var comment:String
}

struct lessonDateDuration: Identifiable{
    var id = UUID()
    var date:Date
    var durationInMinutes:Int
}
