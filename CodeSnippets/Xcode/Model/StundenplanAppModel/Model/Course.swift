//
//  Course.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct Course: Codable, Equatable {

    var contraction: String
    var nameDe: String
    var nameEn: String
    var semesters: [Semester]
    
    enum CodingKeys: String, CodingKey {
        case contraction = "courseContraction"
        case nameDe = "courseNameDe"
        case nameEn = "courseNameEn"
        case semesters = "courseSemesters"
    }
    
    init(contraction : String, nameDe: String, nameEn: String, semesters: [Semester]) {
        self.contraction = contraction
        self.nameDe = nameDe
        self.nameEn = nameEn
        self.semesters = semesters
    }
}
