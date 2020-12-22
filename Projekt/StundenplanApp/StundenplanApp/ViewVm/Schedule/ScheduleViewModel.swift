//
//  ScheduleViewModel.swift
//  ScreensPart1
//
//  Created by MACBOOK on 01.12.20.
//
import SwiftUI
import UIKit
import Foundation


/**
 * The ViewModel providing the necessary information about the schedule.
 * This prepares the lessons received from the backend to a form suitable for display in the ScheduleView
 */
class ScheduleViewModel: ObservableObject{
    
    ///static list of  all days of the week a lecture is possible.
    let days = ["Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"]
    
    ///the currently selected Position from UIPicker in ScheduleView, corresponding to a day in days Array
    var selectedDayIndex = 0
    
    ///all lessons available to the schedule, including block lessons
    @Published var lessons:[Lecture] = []
    
    /**
     * Used to update selectedDayIndex
     */
    func updateDaySelection(dayIdx: Int){
        selectedDayIndex = dayIdx
    }
    
    /**
     * The function called when opening the ScheduleView, fetching all the lessons relevant for user
     */
    func loadLessons(){
        lessons = UserModel().lectureSelections.map{$0.lecture}
    }
}
