//
//  ScheduleForCourseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 20.10.20.
//

import Foundation

struct ScheduleForCourseSemester: Codable {
    let version: Double
    let schedule: [Schedule]
}

struct Schedule: Codable {
    let id, label, docent: String
    let type: TypeEnum
    let style: Style
    let group, starttime, endtime, startdate: String
    let enddate, day, room, splusname: String
    let comment: String
    let sp: SP
}

enum SP: String, Codable {
    case empty = "-"
}

enum Style: String, Codable {
    case blockveranstaltung = "Blockveranstaltung"
    case vorlesungFixzeit = "Vorlesung Fixzeit"
    case übungenFixzeit = "Übungen Fixzeit"
}

enum TypeEnum: String, Codable {
    case awpm = "AWPM"
    case fwpm = "FWPM"
}
