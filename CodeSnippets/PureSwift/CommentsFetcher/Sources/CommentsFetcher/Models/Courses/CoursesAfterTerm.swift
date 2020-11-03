//
//  CoursesAfterTerm.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation

public struct CoursesAfterTerm: Codable {
    public let version: Double
    public let courses: [Course]
}
