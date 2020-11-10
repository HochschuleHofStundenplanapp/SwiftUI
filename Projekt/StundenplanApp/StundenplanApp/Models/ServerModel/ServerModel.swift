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
    
    var lectures : [Lecture]{
        get{
            return serverModelAccess.lectures
        }
        set(lectures){
            serverModelAccess.lectures = lectures
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
