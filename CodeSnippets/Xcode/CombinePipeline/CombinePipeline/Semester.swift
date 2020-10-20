//
//  Semester.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct Semester: Codable, Equatable {

    var name: String
    var course: Course!
    
    enum CodingKeys: String, CodingKey{
        case name = "semesterName"
        case course = "semesterCourse"
    }
    
    init(name: String, course: Course) {
        self.name = name
        self.course = course
    }
}
