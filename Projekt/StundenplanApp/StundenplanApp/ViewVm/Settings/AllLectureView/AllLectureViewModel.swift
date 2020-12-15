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
    private var settingsModel = SettingsModel()
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
        if settingsModel.lectureSelections.contains(where: {$0.lecture.id == lectureSelection.lecture.id}){
            //userModel.courseChangeCleanup(courses: [course])
            settingsModel.lectureSelections.removeAll(where: {$0.lecture.id == lectureSelection.lecture.id})
        }
        else{
            settingsModel.lectureSelections.append(lectureSelection)
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
    
    func saveLecturePlan() {
        //assign settingsmodel to usermodel
        settingsModel.copyTo(model: UserModel())
        print("writing in usermodel")
    }
    
    //help functions
    private func fetchDataFromApi(){
        data.removeAll()
        serverModel.scheduleSelections.removeAll()
        cancel = Pipelines()
            .getLecturesForSelectedCourseSemester(courseSemesters: settingsModel.semesters, term: settingsModel.term)
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
        let settingsData = settingsModel.lectureSelections
        
        data = serverData.map{element in
            var selected = false
            if(settingsData.contains(where: {$0.lecture.id == element.lecture.id})){
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
