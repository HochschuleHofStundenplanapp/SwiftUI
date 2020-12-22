//
//  UserModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 10.11.20.
//

import Foundation
import Combine

class UserModel{
    //access singleton
    private let userModelAccess = UserModelSingleton.sharedInstance
    
    //modify singleton and access data
    var term : String{
        get{
            return userModelAccess.term
        }
        set(value){
            userModelAccess.term = value
        }
    }
    var courses : [Course] {
        get{
            return userModelAccess.courses
        }
        set(courses){
            userModelAccess.courses = courses
        }
    }
    
    var semesters : Dictionary<String,[String]>{
        get{
            return userModelAccess.semesters
        }
        set(sems){
            userModelAccess.semesters = sems
        }
    }
    
    var lectureSelections : [LectureSelection]{
        get{
            return userModelAccess.lectureSelections
        }
        set(lecSecs){
            userModelAccess.lectureSelections = lecSecs
        }
    }
    
    var changes : [Change]{
        get{
            return userModelAccess.changes
        }
        set(ch){
            userModelAccess.changes = ch
        }
    }
    
    //get modified for model changes
    func modelNotifier() -> ObservableObjectPublisher{
      return userModelAccess.objectWillChange
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
    
    func copyTo(model: SettingsModel) {
        model.courses = courses
        model.lectureSelections = lectureSelections
        model.term = term
        model.semesters = semesters
    }
    
}

fileprivate class UserModelSingleton : ObservableObject{
    //instance
    static let sharedInstance : UserModelSingleton = UserModelSingleton()
    
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
    
    private var _changes : [Change] = []
    var changes : [Change]{
        get{
            return _changes
        }
        set(value){
            _changes = value
            modelChanged = true
        }
    }
    
    //constructor
    private init(){}
}

