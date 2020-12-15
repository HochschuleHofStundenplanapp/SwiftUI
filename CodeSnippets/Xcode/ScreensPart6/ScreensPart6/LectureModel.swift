//
//  DummyData.swift
//  ScreensPart6
//
//  Created by Xiongwei Zheng on 01.12.20.
//

import Foundation

//dummy Data
struct lectureModel : Identifiable{
    let id = UUID()
    var time: String
    var lessonName: String
    var room: String
    var lecturer: String
    var type:String
    var addtional:String
    var isBlockLesson:Bool
    var datesForBlocklesson:[lectureDateDuration]
    var comment:String
    var lessonsForWeekDay:[String]
}

struct lectureDateDuration: Identifiable{
    var id = UUID()
    var date:Date
    var durationInMinutes:Int
}
