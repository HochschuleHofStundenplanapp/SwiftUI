//
//  ScheduleForCourseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 20.10.20.
//

import Foundation

struct ScheduleForCourseSemester: Codable{
    let id: String //eventual leading zeroes
    let label, docent, type, group, starttime, endtime, startdate, enddate, day, room, splusname, comment:String
}
