//
//  ScheduleForCourseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 20.10.20.
//

import Foundation

public struct ScheduleForCourseSemester: Codable {
    public let version: Double
    public let schedule: [Lecture]
}

public struct Lecture: Codable {
    public let id, label, docent: String
    public let type: String
    public let style: String
    public let group, starttime, endtime, startdate: String
    public let enddate, day, room, splusname: String
    public let comment: String
    public let sp: String
}
