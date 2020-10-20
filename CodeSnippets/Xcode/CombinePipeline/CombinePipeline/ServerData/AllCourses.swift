//
//  AllCourses.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct AllCourses{

    fileprivate var serverData = ServerData.sharedInstance
    
    func course(at indexPath: IndexPath) -> Course{
        return serverData.allCourses[indexPath.row]
    }
    
    func numberOfEntries() -> Int
    {
        return serverData.allCourses.count
    }
    
    mutating func setCourses(courses: [Course]){
        serverData.allCourses = courses
    }
    
    mutating func sort(){
            serverData.allCourses.sort(by: {$0.nameDe < $1.nameDe})
    }
    
    mutating func clear() {
        serverData.allCourses.removeAll()
    }
}
