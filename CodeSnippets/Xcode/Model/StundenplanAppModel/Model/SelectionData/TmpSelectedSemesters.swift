//
//  TmpSelectedSemesters.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct TmpSelectedSemesters {

    fileprivate var userdata: UserData
    
    init(userdata: UserData){
        self.userdata = userdata
    }
    
    func numberOfEntries(for section : Int) -> Int
    {
        return userdata.selectedCourses[section].semesters.count
    }
    
    func contains(semester: Semester) -> Bool{
        return userdata.selectedSemesters.contains(semester)
    }
    
    mutating func append(semester : Semester) {
        userdata.selectedSemesters.append(semester)
    }
    
    mutating func remove(semester: Semester){
        let index = userdata.selectedSemesters.firstIndex(of: semester)
        userdata.selectedSemesters.remove(at: index!)
    }
    
    func semester(at indexPath: IndexPath) -> Semester{
        return userdata.selectedCourses[indexPath.section].semesters[indexPath.row]
    }
    
    func allSemesters() -> [Semester]{
        return userdata.selectedSemesters
    }
    
    mutating func removeSemester(with course: Course){
        for semester in userdata.selectedSemesters{
            if(semester.course == course){
                let index = userdata.selectedSemesters.firstIndex(of: semester)
                userdata.selectedSemesters.remove(at: index!)
            }
        }
    }
    
    func hasSelection() -> Bool{
        return !userdata.selectedSemesters.isEmpty
    }
    
    func allSelectedSemesters() -> String
    {
        if userdata.selectedSemesters.count == 0
        {
            return "..."
        }
        
        var res = ""
        var sep = ""
        
        for course in userdata.selectedCourses
        {
            var semesterList : [Semester] = []
            for semester in userdata.selectedSemesters
            {
                if course.nameDe == semester.course.nameDe{
                    semesterList.append(semester)
                }
            }
            semesterList.sort(by: {$0.name < $1.name})
            
            for sem in semesterList{
                sep.append(sem.name+",")
            }
            //if sep.characters.last == ","{
          if sep.last! == ","{
                sep.remove(at: sep.index(before: sep.endIndex))
            }
            res.append(sep+"|")
            sep = ""
        }
        res.remove(at: res.index(before: res.endIndex))

        return res
    }
    
    mutating func clear() {
        userdata.selectedSemesters.removeAll()
    }
}
