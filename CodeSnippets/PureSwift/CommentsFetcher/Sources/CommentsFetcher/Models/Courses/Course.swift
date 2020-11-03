//
//  Course.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation

public struct Course: Codable {
    public let course, year: String
    public let labels: Labels
    public let semester: [String]
}
