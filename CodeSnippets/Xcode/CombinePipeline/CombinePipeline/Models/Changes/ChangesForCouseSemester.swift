//
//  ChangesForCouseSemester.swift
//  CombinePipeline
//
//  Created by MACBOOK on 21.10.20.
//

import Foundation

struct ChangesForCourseSemester: Codable{
    let id:String //possible leading zeroes
    let label, docent, comment, reason, group, splusname : String
    let original:Lecture
    let alternative:Lecture
}
