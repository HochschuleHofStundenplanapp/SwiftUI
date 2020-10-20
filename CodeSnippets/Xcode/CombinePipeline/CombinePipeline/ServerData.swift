//
//  ServerData.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit
/**
 Speichert die vom Server kommenden Infos über die 
 * angebotenen Studiengänge und Semester -> allCourses
 * Vorlesungen der ausgewählten Studiengänge -> schedule
 */

struct ServerData {

    var allCourses : [Course] = []
    //var allChanges : [ChangedLecture] = []
    //var lastAllChanges : [ChangedLecture] = []
    var schedule: Schedule = Schedule()
        
    static var sharedInstance = ServerData()
}
