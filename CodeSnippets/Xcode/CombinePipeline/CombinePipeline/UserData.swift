//
//  UserData.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit
/**
 Speichert die **vom User ausgewählten** Infos über
 * Season -> Sommer- oder Wintersemester
 * Courses -> Studiengänge mit gewählten Semestern
 * Semesters -> Semester mit Studiengängen
 * Lectures -> Vorlesungen mit Info über das zugehörige Semester
 */
struct UserData: Codable{
    
    static var sharedInstance = UserData()
    
    var calendarSync: Bool = false
    var selectedSeason : String = "SS"
    var selectedCourses : [Course] = []
    var selectedSemesters : [Semester] = []
    var savedSplusnames : [String] = [String]()//Auslagern
    var selectedSchedule: Schedule = Schedule()
    var oldChanges : [ChangedLecture] = []
    
    var removedLectures: [Lecture] = []
    var addedLectures: [Lecture] = []
    
    
    enum CodingKeys: String, CodingKey{
        case calendarSync = "calendarSync"
        case selectedSeason = "selectedSeason"
        case selectedCourses = "selectedCourses"
        case selectedSemesters = "selectedSemesters"
        case savedSplusnames = "savedSplusnames"
        case selectedSchedule = "selectedSchedule"
        case removedLectures = "removedLectures"
        case addedLectures = "addedLectures"
        case oldChanges = "oldChanges"
    }
    
    func copy() -> Any {
        var copy = UserData()
        copy.selectedSeason = selectedSeason
        copy.selectedCourses = selectedCourses
        copy.selectedSemesters = selectedSemesters
        copy.selectedSchedule = selectedSchedule.copy() as! Schedule
        
        copy.removedLectures = removedLectures
        copy.addedLectures = addedLectures
        copy.calendarSync = calendarSync
        return copy
    }
}
