//
//  ServerModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import Foundation
import Combine

class ServerModel{
    //access singleton
    private let serverModelAccess = ServerModelSingleton.sharedInstance
    
    //modify singleton and access data
    var allCourses : [Course] {
        get{
            return serverModelAccess.allCourses
        }
        set(courses){
            serverModelAccess.allCourses = courses
        }
    }
    
    var changes : [Change] {
        get{
            return serverModelAccess.changes
        }
        set(changes){
            serverModelAccess.changes = changes
        }
    }
    
    var scheduleSelections : [ScheduleSelection]{
        get{
            return serverModelAccess.scheduleSelections
        }
        set(schedSel){
            serverModelAccess.scheduleSelections = schedSel
        }
    }
    
    var lectureSelections : [LectureSelection]{
        get{
            return scheduleSelections.flatMap{$0.toLectureSelections()}
        }
    }
    
    //get modified for model changes
    func modelNotifier() -> ObservableObjectPublisher{
      return serverModelAccess.objectWillChange
    }
    
    //validate courses
    func allCoursesAreValid() -> Bool{
        //Add further validation logic if needed
        return !(allCourses.isEmpty)
    }
    
    //validate schedule selection
    func scheduleSelectionsIsValid() -> Bool{
        return !(scheduleSelections.isEmpty)
    }
    
    //cleanup functions
    func termChangeCleanup(){
        allCourses.removeAll()
        semesterChangeCleanup()
    }
    
    func semesterChangeCleanup(){
        scheduleSelections.removeAll()
    }
}

fileprivate class ServerModelSingleton : ObservableObject{
    //instance
    static let sharedInstance : ServerModelSingleton = ServerModelSingleton()
    
    //published var for combine
    @Published var modelChanged : Bool = false
    
    //data structures for storing data
    private var _allCourses : [Course] = []
    var allCourses : [Course]{
        get {
            return _allCourses
        }
        set(value){
            _allCourses = value
            modelChanged = true
        }
    }
    
    private var _changes : [Change] = []
    var changes : [Change]{
        get {
            return _changes
        }
        set(value){
            _changes = value
            modelChanged = true
        }
    }
    
    private var _scheduleSelections : [ScheduleSelection] = []
    var scheduleSelections : [ScheduleSelection]{
        get {
            return _scheduleSelections
        }
        set(value){
            _scheduleSelections = value
            modelChanged = true
        }
    }
    
    //constructor
    private init(){}
}
