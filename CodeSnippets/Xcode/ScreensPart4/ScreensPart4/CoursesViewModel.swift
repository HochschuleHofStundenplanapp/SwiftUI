//
//  CoursesViewModel.swift
//  ScreensPart4
//
//  Created by Xiongwei Zheng on 08.12.20.
//

import Foundation

class CoursesViewModel: ObservableObject {
    @Published var allCourses : [coursesModel] = [
        coursesModel(label: "Betriebswirtschaft"),
        coursesModel(label: "Medieninformatik"),
        coursesModel(label: "Mobile Computing"),
        coursesModel(label: "Textildesign"),
        coursesModel(label: "Wirtschaftsrecht")
    ]
    
    func fetchData() {
        
    }
}
