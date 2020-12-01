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
    ///all lessons available to the schedule, including block lessons
    @Published var lessons:[lessonModel] = []
    @Published var lessonsForWeekDay: [[lessonModel]]
    
    
    /**
     * The function called when opening the ScheduleView, fetching all the lessons needed
     */
    func loadLessons(){
        
    }
    
    /**
     * constructing the schedule out of the lessons fetched
     */
    func constructSchedule(){
        //TODO: Refresh lessonsForWeekDay
        
        lessons = [
        //REGULAR LESSONS
        lessonModel(time: "8:00 - 9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", weekDay: 0,isBlockLesson: false, datesForBlocklesson: []),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik", weekDay: 0 ,isBlockLesson: false, datesForBlocklesson: []),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik", weekDay: 1 , isBlockLesson: false, datesForBlocklesson: []),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",weekDay: 2, isBlockLesson: false, datesForBlocklesson: []),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",weekDay: 3, isBlockLesson: false, datesForBlocklesson: []),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",weekDay: 4, isBlockLesson: false, datesForBlocklesson: []),
            
        //BLOCKLESSONS
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotiksblockstunde" ,room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik", weekDay: 5,isBlockLesson: true, datesForBlocklesson: [lessonDateDuration(date: Date(), durationInMinutes: 180)]),
        lessonModel(time: "13:00 - 19:00", lessonName: "Irendein langes Fach", room: "FG_023b", lecturer: "Prof. Dr. Christian Anderson", type: "Vortrag", addtional: "Einfach nur sehr lange Zeitverschwendung", weekDay: 5, isBlockLesson: true, datesForBlocklesson: [lessonDateDuration(date: Date(), durationInMinutes: 180)])
    ]
    }
}
