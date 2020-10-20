//
//  AllChanges.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct AllChanges {

    fileprivate var userData = UserData.sharedInstance
    
    func numberOfEntries(for section : Int) -> Int
    {
        return userData.oldChanges.count
    }
    
    func getElement(at index : Int) -> ChangedLecture
    {
        return userData.oldChanges[index]
    }
    
    func getChangedLectures() -> [ChangedLecture] {
        return userData.oldChanges
    }
    
    mutating func append(chLectures : [ChangedLecture]) {
        
        for lec in chLectures{
            //Check chLecture duplicates
            if !userData.oldChanges.contains(lec){
                userData.oldChanges.append(lec)
            }
        }
    }
    
    mutating func clear() {
        userData.oldChanges.removeAll()
    }
}
