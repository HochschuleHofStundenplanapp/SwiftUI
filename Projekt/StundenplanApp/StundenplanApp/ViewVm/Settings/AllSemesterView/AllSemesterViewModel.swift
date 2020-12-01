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
    
    var selectedSemesters = [(course: Course, semester: String, selected: Bool)]()
    
    var allCourses = [Course]()
    
    //model synchronisation fields
    private let userModel = UserModel()
    private let serverModel = ServerModel()
    
    //functions
    func loadData(){
        allCourses = userModel.courses
        loadSelectedSemesters()
    }
    
    private func loadSelectedSemesters(){
        selectedSemesters.removeAll()
        allCourses.forEach{ cor in
            let userSemSelection = userModel.semesters[cor.course]
            for sem in cor.semester {
                var sel = false
                if let existingUserSemSelection = userSemSelection {
                    if existingUserSemSelection.contains(sem) {
                        sel = true
                    }
                }
                selectedSemesters.append((course: cor, semester: sem, selected: sel))
            }
        }
        dataChanged = true
    }
    
    func isSemesterInCourseSelected(course: Course, semester: String) -> Bool {
        return selectedSemesters.contains(where: {
            $0.course.course == course.course && $0.semester == semester && $0.selected
        })
    }
    
    func updateSemesterSelection(course: Course, semester: String){
        if var allSelectedSemesterOfCourse = userModel.semesters[course.course]{
            //update semesters
            //check if choosen semester is in usermodel.semesters in context of course
            if let index = allSelectedSemesterOfCourse.firstIndex(of: semester){
                userModel.semesterChangeCleanup()
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
        serverModel.semesterChangeCleanup()
        loadSelectedSemesters()
    }
    
    
}
