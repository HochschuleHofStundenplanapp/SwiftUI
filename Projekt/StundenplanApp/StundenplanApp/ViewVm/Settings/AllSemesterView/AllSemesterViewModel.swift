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
    //var selectedSemesters = [(course: Course, semester: [String])]()
    
    var allCourses = [Course]()
    
    //model synchronisation fields
    private let userModel = UserModel()
    
    //functions
    func loadData(){
        allCourses = userModel.courses
        loadSelectedSemesters()
        dataChanged = true
    }
    
    private func loadSelectedSemesters(){
        //selectedSemesters = userModel.semesters
    }
    
    func updateSemesterSelection(course: Course, semester: String){
        if var allSelectedSemesterOfCourse = userModel.semesters[course.course]{
            //update semesters
            //check if choosen semester is in usermodel.semesters in context of course
            if let index = allSelectedSemesterOfCourse.firstIndex(of: semester){
                allSelectedSemesterOfCourse.remove(at: index)
            }
            else{
                allSelectedSemesterOfCourse.append(semester)
            }
            userModel.semesters[course.course] = allSelectedSemesterOfCourse
            
        }
        else{
            //course does not exist in semester selection
            userModel.semesters[course.course] = [semester]
        }
        
        
        //TODO: UPDATE FLAGS IN UI
    }
    
    
}
