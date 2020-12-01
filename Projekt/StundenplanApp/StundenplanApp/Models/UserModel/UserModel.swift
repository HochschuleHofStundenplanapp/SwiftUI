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
    
    var lectures : [Lecture]{
        get{
            return userModelAccess.lectures
        }
        set(lectures){
            userModelAccess.lectures = lectures
        }
    }
    
    //get modified for model changes
    func modelNotifier() -> ObservableObjectPublisher{
      return userModelAccess.objectWillChange
    }
    
    //cleanup functions
    func termChangeCleanup(){
        courses.removeAll()
        courseChangeCleanup(courses: courses)
    }
    
    func courseChangeCleanup(courses: [Course]){
        for course in courses {
            semesters.removeValue(forKey: course.course)
        }
        semesterChangeCleanup()
    }
    
    func semesterChangeCleanup(){
        lectures.removeAll()
    }
    
    //check if there are any selected semesters (meaning that there is at least on Array of Semesters in the semesters-Dictionary that is not empty)
    func hasSemesters() -> Bool{
        //filter all values of the semesters-Dictionary and get all values where the Array of Semesters is not empty
        let existingSemesters = semesters.values.filter{!$0.isEmpty}
        return !existingSemesters.isEmpty
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
    
    private var _lectures : [Lecture] = []
    var lectures : [Lecture]{
        get {
            return _lectures
        }
        set(value){
            _lectures = value
            modelChanged = true
        }
    }
    
    //constructor
    private init(){}
}

