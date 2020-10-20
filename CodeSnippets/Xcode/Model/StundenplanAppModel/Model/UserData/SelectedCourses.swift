//
//  SelectedCourses.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct SelectedCourses {

    fileprivate var userdata = UserData.sharedInstance
    
    func contains(course: Course) -> Bool{
        return userdata.selectedCourses.contains(course)
    }
}
