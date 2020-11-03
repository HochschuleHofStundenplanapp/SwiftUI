//
//  ChangesForCouseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 21.10.20.
//

import Foundation

public struct Change: Codable{
    public let id:String //possible leading zeroes
    public let label, docent, comment, reason, text,group, splusname : String
    public let original:LectureChangeInfo
    public let alternative:LectureChangeInfo
}

public struct ChangesForCourseSemester : Codable {
    public let version: Double
    public let changes: [Change]
}

