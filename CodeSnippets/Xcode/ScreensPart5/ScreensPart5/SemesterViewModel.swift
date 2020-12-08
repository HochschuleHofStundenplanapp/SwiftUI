//
//  SemesterViewModel.swift
//  ScreensPart5
//
//  Created by Xiongwei Zheng on 08.12.20.
//

import Foundation

class SemesterViewModel: ObservableObject {
    @Published var allSemester: [semesterModel] = [
        semesterModel(semester: "1"),
        semesterModel(semester: "3"),
        semesterModel(semester: "5"),
        semesterModel(semester: "7")
    ]
    
    func fetchData() {
        
    }
}
