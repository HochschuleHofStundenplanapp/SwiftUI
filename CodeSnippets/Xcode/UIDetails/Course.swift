//
//  Course.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation

struct Course: Codable{
    let course, year: String
    let labels: Labels
    let semester: [String]
}
