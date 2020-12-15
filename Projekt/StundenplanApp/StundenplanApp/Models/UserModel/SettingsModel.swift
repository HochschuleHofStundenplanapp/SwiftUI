//
//  UserModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 10.11.20.
//

import Foundation
import Combine

class SettingsModel{
    //access singleton
    private let settingsModelAccess = SettingsModelSingleton.sharedInstance
    
    //modify singleton and access data
    var term : String{
        get{
            return settingsModelAccess.term
        }
        set(value){
            settingsModelAccess.term = value
        }
    }
    var courses : [Course] {
        get{
            return settingsModelAccess.courses
        }
        set(courses){
            settingsModelAccess.courses = courses
        }
    }
    
    var semesters : Dictionary<String,[String]>{
        get{
            return settingsModelAccess.semesters
        }
        set(sems){
            settingsModelAccess.semesters = sems
        }
    }
    
    var lectureSelections : [LectureSelection]{
        get{
            return settingsModelAccess.lectureSelections
        }
        set(lecSecs){
            settingsModelAccess.lectureSelections = lecSecs
        }
    }
    
    //get modified for model changes
    func modelNotifier() -> ObservableObjectPublisher{
      return settingsModelAccess.objectWillChange
    }
    
    //cleanup functions
    func termChangeCleanup(){
        courses.removeAll()
        courseChangeCleanup(courseNames: Array(semesters.keys))
    }
    
    func courseChangeCleanup(courses: [Course]){
        courseChangeCleanup(courseNames: courses.map{$0.course})
    }
    
    private func courseChangeCleanup(courseNames: [String]){
        for course in courseNames {
            semesters.removeValue(forKey: course)
        }
        semesterChangeCleanup()
    }
    
    func semesterChangeCleanup(){
        lectureSelections.removeAll()
    }
    
    //check if there are any selected semesters (meaning that there is at least on Array of Semesters in the semesters-Dictionary that is not empty)
    func hasSemesters() -> Bool{
        //filter all values of the semesters-Dictionary and get all values where the Array of Semesters is not empty
        let existingSemesters = semesters.values.filter{!$0.isEmpty}
        return !existingSemesters.isEmpty
    }
    
    func copyTo(model: UserModel) {
        model.courses = courses
        model.lectureSelections = lectureSelections
        model.term = term
        model.semesters = semesters
    }
    
}

fileprivate class SettingsModelSingleton : ObservableObject{
    //instance
    static let sharedInstance : SettingsModelSingleton = SettingsModelSingleton()
    
    //published var for combine
    @Published var modelChanged : Bool = false
    
    //data structures for storing data
    private var _term : String = "SS"
    var term : String{
        get{
            return _term
        }
        set(value){
            _term = value
            modelChanged = true
        }
    }
    
    private var _courses : [Course] = []
    var courses : [Course]{
        get {
            return _courses
        }
        set(value){
            _courses = value
            modelChanged = true
        }
    }
    
    private var _semesters : Dictionary<String,[String]> = [:]
    var semesters : Dictionary<String,[String]>{
        get{
            return _semesters
        }
        set(value){
            _semesters = value
            modelChanged = true
        }
    }
    
    private var _lectureSelections : [LectureSelection] = []
    var lectureSelections : [LectureSelection]{
        get {
            return _lectureSelections
        }
        set(value){
            _lectureSelections = value
            modelChanged = true
        }
    }
    
    //constructor
    private init(){}
}

