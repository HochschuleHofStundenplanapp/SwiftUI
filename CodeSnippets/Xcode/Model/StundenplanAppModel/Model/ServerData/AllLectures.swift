//
//  AllLectures.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct AllLectures {

    fileprivate var serverData = ServerData.sharedInstance
    
    func numberOfEntries(for section : Int) -> Int
    {
        return serverData.schedule.daySize(at: section)
    }
    
    func getElement(at indexPath : IndexPath) -> Lecture
    {
        return serverData.schedule.lecture(at: indexPath)
    }
    
    func getLectures() -> [[Lecture]] {
        return serverData.schedule.lectures
    }
    
    mutating func append(lectures : [Lecture]) {
        
        for lec in lectures{
            let dayIndex = Constants.weekDays.firstIndex(of: lec.day)!
            
            //Check lecture duplicates
            if !serverData.schedule.lectures[dayIndex].contains(lec) {
                serverData.schedule.add(lecture: lec, at: dayIndex)
            }
        }
    }
    
    mutating func sort(){
        for i in 0..<serverData.schedule.lectures.count{
            serverData.schedule.lectures[i].sort(by: {$0.startTime < $1.startTime})
        }
    }
    
    mutating func clear() {
        serverData.schedule.clear()
    }
}
