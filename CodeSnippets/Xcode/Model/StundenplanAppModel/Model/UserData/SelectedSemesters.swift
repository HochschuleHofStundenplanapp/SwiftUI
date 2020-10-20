//
//  SelectedSemesters.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

struct SelectedSemesters{
    
    fileprivate var userdata = UserData.sharedInstance

    func contains(semester: Semester) -> Bool{
        return userdata.selectedSemesters.contains(semester)
    }
}
