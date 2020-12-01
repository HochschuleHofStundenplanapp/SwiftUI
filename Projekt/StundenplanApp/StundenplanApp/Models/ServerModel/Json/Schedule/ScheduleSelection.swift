//
//  ScheduleSelection.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import Foundation

struct ScheduleSelection{
    let courseName : String
    let semester : String
    let lectures: [Lecture]
    
    func toLectureSelections() -> [LectureSelection]{
        return lectures.map{
            LectureSelection(courseName: courseName, semester: semester, lecture: $0)
        }
    }
}
