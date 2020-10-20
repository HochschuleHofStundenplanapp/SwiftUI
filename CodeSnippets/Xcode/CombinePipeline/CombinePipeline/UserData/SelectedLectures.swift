//
//  SelectedLectures.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct SelectedLectures{
    
    fileprivate var userdata = UserData.sharedInstance
    
    func numberOfEntries(for section : Int) -> Int{
        return userdata.selectedSchedule.daySize(at: section)
    }
    
    func getElement(at indexPath : IndexPath) -> Lecture{
        return userdata.selectedSchedule.lecture(at: indexPath)
    }
    
    func getOneDimensionalList() -> [Lecture]{
        let list = userdata.selectedSchedule.getOneDimensionalList()
        return list
    }
    
    mutating func sortLecturesForSchedule(){
        for i in 0..<userdata.selectedSchedule.lectures.count{
            userdata.selectedSchedule.lectures[i].sort(by: {$0.startTime < $1.startTime})
        }
    }
    
    func contains(lecture: Lecture) -> Bool{
        return userdata.selectedSchedule.contains(lecture: lecture)
    }
}
