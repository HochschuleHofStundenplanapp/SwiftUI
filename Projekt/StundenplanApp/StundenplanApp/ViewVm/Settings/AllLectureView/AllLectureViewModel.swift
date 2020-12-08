//
//  AllLectureViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import SwiftUI
import Combine

class AllLectureViewModel : ObservableObject{
    @Published var dataIsAvailable = false
    var data = [(lectureSelection: LectureSelection, selected: Bool)]()
    let days = ["Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"]
    
    var selectedDayIndex = 0
    
    private var cancel : AnyCancellable? = nil
    private let userModel = UserModel()
    private let serverModel = ServerModel()
    
    init(){
        mergeModels()
    }
    
    func loadData(){
        if serverModel.scheduleSelectionsIsValid(){
            self.dataIsAvailable = true
            return
        }
        
        fetchDataFromApi()
    }
    
    func updateScheduleSelection(lectureSelection: LectureSelection){
        //dataisAvailable = false
        if userModel.lectureSelections.contains(where: {$0.lecture.id == lectureSelection.lecture.id}){
            //userModel.courseChangeCleanup(courses: [course])
            userModel.lectureSelections.removeAll(where: {$0.lecture.id == lectureSelection.lecture.id})
        }
        else{
            userModel.lectureSelections.append(lectureSelection)
            //userModel.semesters[course.course] = [String]()
        }
        mergeModels()
        dataIsAvailable = true
    }
    
    func updateDaySelection(dayIdx: Int){
        selectedDayIndex = dayIdx
        mergeModels()
        dataIsAvailable = true
    }
    
    //help functions
    private func fetchDataFromApi(){
        data.removeAll()
        serverModel.scheduleSelections.removeAll()
        cancel = Pipelines()
            .getLecturesForSelectedCourseSemester(courseSemesters: userModel.semesters, term: userModel.term)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {_ in
                self.mergeModels()
                self.dataIsAvailable = true
            },
            receiveValue: {value in
                self.data.append(contentsOf: value.toLectureSelections().map{(lectureSelection: $0, selected: false)})
                self.serverModel.scheduleSelections.append(value)
            })
    }
    
    private func mergeModels(){
        let serverData = serverModel.lectureSelections
        let userData = userModel.lectureSelections
        
        data = serverData.map{element in
            var selected = false
            if(userData.contains(where: {$0.lecture.id == element.lecture.id})){
                selected = true
            }
            return (lectureSelection: element, selected: selected)
        }.filter{
            $0.lectureSelection.lecture.day == days[selectedDayIndex]
        }.sorted{l1, l2 in
            l1.lectureSelection.lecture.starttime < l2.lectureSelection.lecture.starttime
        }
    }
}
