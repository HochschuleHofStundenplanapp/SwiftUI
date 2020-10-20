//
//  TmpSelectedLectures.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct TmpSelectedLectures {

    fileprivate var userdata: UserData
    
    init(userdata: UserData){
        self.userdata = userdata
    }
    
    func numberOfEntries(for section : Int) -> Int
    {
        return userdata.selectedSchedule.daySize(at: section)
    }
    
    func getElement(at indexPath : IndexPath) -> Lecture
    {
        return userdata.selectedSchedule.lecture(at: indexPath)
    }
    
    func getIndexPath(for element: Lecture) -> IndexPath{
        
        var iP = NSIndexPath()
        
        let lectures = userdata.selectedSchedule.lectures
        
        for i in 0..<lectures.count{
            for j in 0..<lectures[i].count{
                if lectures[i][j] == element{
                    iP = NSIndexPath(row: j, section: i)
                }
            }
        }
        return iP as IndexPath
    }
    
    mutating func set(lectures: [[Lecture]]) {
        userdata.selectedSchedule.lectures = lectures
    }
    
    mutating func add(lecture : Lecture, at day : Int){
        userdata.selectedSchedule.add(lecture: lecture, at: day)
    }
    
    mutating func add(lecture : Lecture){
        let dayIndex = Constants.weekDays.firstIndex(of: lecture.day)!
        userdata.selectedSchedule.add(lecture: lecture, at: dayIndex)
    }
    
    mutating func clear() {
        userdata.selectedSchedule.clear()
    }
    
    mutating func remove(at indexPath: IndexPath){
        userdata.selectedSchedule.removeLecture(at: indexPath)
    }
    
    mutating func removeLectures(with course: Course){
        
        var lecturesToBeDeleted : [Lecture] = [Lecture]()
        
        for day in userdata.selectedSchedule.lectures{
            for lecture in day{
                if(lecture.semester.course == course){
                    
                    lecturesToBeDeleted.append(lecture)
                }
            }
        }
        
        for lecture in lecturesToBeDeleted{
            
            let i = Constants.weekDays.firstIndex(of: lecture.day)!
            removeLecture(lecture: lecture, day: i)
        }
    }
    
    mutating func removeLectures(for semester: Semester){
        
        var lecturesToBeDeleted : [Lecture] = [Lecture]()
        
        for day in userdata.selectedSchedule.lectures{
            for lecture in day{
                if(lecture.semester == semester){
                    
                    lecturesToBeDeleted.append(lecture)
                }
            }
        }
        
        for lecture in lecturesToBeDeleted{
            
            let i = Constants.weekDays.firstIndex(of: lecture.day)!
            removeLecture(lecture: lecture, day: i)
        }
    }
    
    func contains(lecture: Lecture) -> Bool{
        return userdata.selectedSchedule.contains(lecture: lecture)
    }
    
    private mutating func removeLecture(lecture : Lecture, day : Int){
        if let index = userdata.selectedSchedule.lectures[day].firstIndex(of: lecture){
            userdata.selectedSchedule.lectures[day].remove(at: index)
        }
    }
    
    func getOneDimensionalList() -> [Lecture]{
        let list = userdata.selectedSchedule.getOneDimensionalList()
        return list
    }
    
    func hasSelection() -> Bool{
        return !userdata.selectedSchedule.isEmpty()
    }
}
