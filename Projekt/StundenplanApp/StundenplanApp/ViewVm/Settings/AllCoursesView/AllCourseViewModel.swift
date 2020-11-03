//
//  AllCourseViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import Combine

class AllCoursesViewModel : ObservableObject {
    @Published var dataisAvailable: Bool = false
    var data: [Course] = []
    var cancel: AnyCancellable? = nil
    
    func getCourses(term: String) {
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getCoursesAfterTerm(term: term).sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            self.data = value.courses
        })
    }
}
