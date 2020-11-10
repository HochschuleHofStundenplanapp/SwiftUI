//
//  AllCourseViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import Combine

class AllCoursesViewModel : ObservableObject {
    var selectedCourses: [Course] = []
    var term: String
    @Published var dataisAvailable: Bool = false
    var data: [Course] = []
    var cancel: AnyCancellable? = nil
    
    public init(term: String) {
        self.term = term
    }
    
    func getCourses() {
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getCoursesAfterTerm(term: self.term).sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            self.data = value.courses
        })
    }
}
