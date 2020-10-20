//
//  Schedule.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct Schedule: Codable, Equatable {

    var lectures: [[Lecture]]
    
    enum CodingKeys: String, CodingKey{
        case lectures = "lectures"
    }
    
    init() {
        lectures = [[],[],[],[],[],[]]
    }
    
    mutating func add(lecture: Lecture, at day: Int){
        lectures[day].append(lecture)
    }
    
    mutating func clear(){
        lectures = [[],[],[],[],[],[]]
    }
    
    func daySize(at section: Int) -> Int{
        return lectures[section].count
    }
    
    func lecture(at indexPath: IndexPath) -> Lecture{
        return lectures[indexPath.section][indexPath.row]
    }
    
    mutating func removeLecture(at indexpath: IndexPath){
        lectures[indexpath.section].remove(at: indexpath.row)
    }
    
    func copy() -> Any {
        var copy = Schedule()
        
        for (index, _) in lectures.enumerated(){
            copy.lectures[index] = lectures[index]
        }
        
        return copy
    }
    
    func contains(lecture: Lecture) -> Bool{
                
        for day in lectures{
            for lec in day{
                if lec == lecture{
                    return true
                }
            }
        }
        
        return false
    }
    
    func getOneDimensionalList() -> [Lecture]{        
        var newList : [Lecture] = [Lecture]()
        
        for day in lectures{
            for lecture in day{
                newList.append(lecture)
            }
        }
        return newList
    }
    

    func isEmpty() -> Bool{
        
        return (lectures[0].isEmpty && lectures[1].isEmpty && lectures[2].isEmpty && lectures[3].isEmpty && lectures[4].isEmpty && lectures[5].isEmpty)
    }
}
