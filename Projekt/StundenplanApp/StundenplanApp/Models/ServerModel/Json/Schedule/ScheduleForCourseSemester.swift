//
//  ScheduleForCourseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 20.10.20.
//

import Foundation

struct ScheduleForCourseSemester: Codable {
    let version: Double
    let schedule: [Lecture]
}

struct Lecture: Codable {
    let id, label, docent: String
    let type: String
    let style: String
    let group, starttime, endtime, startdate: String
    let enddate, day, room, splusname: String
    let comment: String
    let sp: String
}

extension Lecture{
    func isBlockLecture() -> Bool {
        return style.lowercased().contains("block") || type.lowercased().contains("block")
    }
}
