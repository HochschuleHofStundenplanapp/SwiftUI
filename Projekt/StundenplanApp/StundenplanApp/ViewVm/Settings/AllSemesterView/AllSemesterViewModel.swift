//
//  AllSemesterViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 17.11.20.
//
/**
 This ViewModel should show all avalible semesters for the selected courses of the user + let him/her choose the semester.
 */

import Combine

class AllSemesterViewModel : ObservableObject{
    //fields
    @Published var dataChanged = false
    var selectedSemesters = [(course: Course, semester: [String])]()
    
    var allCourses = [Course]()
    
    //model synchronisation fields
    private let userModel = UserModel()
    
    
    //constructors
    init(){
        
    }
    
    //functions
    func loadData(){
        allCourses = userModel.courses
        loadSelectedSemesters()
        dataChanged = true
    }
    
    private func loadSelectedSemesters(){
        selectedSemesters = userModel.semesters
    }
    
    func updateSemesterSelection(){
        
    }
    
    
}
