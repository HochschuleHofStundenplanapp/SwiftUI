//
//  AllCourseViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import Combine

class AllCoursesViewModel : ObservableObject {
    //term
    var term: String
    
    //swiftui + combine fields
    @Published var dataisAvailable: Bool = false
    var data: [(course: Course, selected: Bool)] = []
    var cancel: AnyCancellable? = nil
    
    //model fields
    let serverModel = ServerModel()
    let settingsModel = SettingsModel()
    
    
    
    public init(term: String) {
        self.term = term
        mergeModels()
    }
    
    func getCourses() {
        if serverModel.allCoursesAreValid(){
            self.dataisAvailable = true
            return
        }
        
        fetchDataFromApi()
    }
    
    
    func updateCourseSelection(course: Course){
        //dataisAvailable = false
        if settingsModel.courses.contains(where: {$0.course == course.course}){
            settingsModel.courseChangeCleanup(courses: [course])
            settingsModel.courses.removeAll(where: {$0.course == course.course})
        }
        else{
            settingsModel.courses.append(course)
            settingsModel.semesters[course.course] = [String]()
        }
        mergeModels()
        dataisAvailable = true
    }
    
    
    //help functions
    private func fetchDataFromApi(){
        //fetch data
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getCoursesAfterTerm(term: self.term).sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            let serverData = value.courses.sorted{course1, course2 in
                course1.course < course2.course
            }
            self.data = serverData.map{(course: $0,selected: false)}
            self.serverModel.allCourses = serverData
        })
    }
    
    private func mergeModels(){
        let serverCourses = self.serverModel.allCourses
        let selectedCourses = self.settingsModel.courses
        
        data = serverCourses.map{serverCourse in
            var selected = false
            if(selectedCourses.contains(where: {$0.course == serverCourse.course})){
                selected = true
            }
            return (course: serverCourse, selected: selected)
        }
    }
}
