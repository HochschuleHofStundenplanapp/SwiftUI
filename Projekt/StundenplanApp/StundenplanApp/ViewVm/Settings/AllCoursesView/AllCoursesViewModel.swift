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
    let userModel = UserModel()
    
    
    
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
        if userModel.courses.contains(where: {$0.course == course.course}){
            userModel.courses.removeAll(where: {$0.course == course.course})
        }
        else{
            userModel.courses.append(course)
        }
        mergeModels()
        dataisAvailable = true
    }
    
    /*func applyTermToUserModel(){
        if(userModel.term != term){
            userModel.term = term
        }
    }*/
    
    //help functions
    private func fetchDataFromApi(){
        //delete usermodel courses
        //userModel.termChangeCleanup()
        
        //apply term to usermodel :D
        //applyTermToUserModel()
        
        //fetch data
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getCoursesAfterTerm(term: self.term).sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            self.data = value.courses.map{(course: $0,selected: false)}
            self.serverModel.allCourses = value.courses
        })
    }
    
    private func mergeModels(){
        let serverCourses = self.serverModel.allCourses
        let selectedCourses = self.userModel.courses
        
        data = serverCourses.map{serverCourse in
            var selected = false
            if(selectedCourses.contains(where: {$0.course == serverCourse.course})){
                selected = true
            }
            return (course: serverCourse, selected: selected)
        }
    }
}