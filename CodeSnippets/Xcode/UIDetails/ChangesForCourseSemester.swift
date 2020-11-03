//
//  ChangesForCouseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 21.10.20.
//

import Foundation

struct Change: Codable{
    let id:String //possible leading zeroes
    let label, docent, comment, reason, text,group, splusname : String
    let original:LectureChangeInfo
    let alternative:LectureChangeInfo
}

struct ChangesForCourseSemester : Codable {
    let version: Double
    let changes: [Change]
}

