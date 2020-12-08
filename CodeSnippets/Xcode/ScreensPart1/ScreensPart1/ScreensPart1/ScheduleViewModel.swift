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
    @Published var lessonsForWeekDay: [[lessonModel]] = [[]]
    
    
    
    /**
     * The function called when opening the ScheduleView, fetching all the lessons needed
     */
    func loadLessons(){
        //load lessons here
        
        
        //at the moment, just load Dummy Data
        constructSchedule()
    }
    
    /**
     * constructing the schedule out of the lessons fetched
     */
    func constructSchedule(){
        //TODO: Refresh lessonsForWeekDay
        
        lessons = [
        //REGULAR LESSONS
            lessonModel(id: "2dfefscdsc", starttime: "8:00", endtime: "9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", day: "Montag",isBlockLesson: false, datesForBlocklesson: []),
                lessonModel(id: "8udwjbnkf", starttime: "8:00", endtime: "9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", day: "Dienstag",isBlockLesson: false, datesForBlocklesson: []),
                lessonModel(id: "7hiuef", starttime: "8:00", endtime: "9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", day: "Mittwoch",isBlockLesson: false, datesForBlocklesson: []),
            //REGULAR LESSONS
                lessonModel(id: "4ufifjawaf", starttime: "8:00", endtime: "9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", day: "Donnerstag",isBlockLesson: false, datesForBlocklesson: []),
            //REGULAR LESSONS
                lessonModel(id: "f4fer4", starttime: "8:00", endtime: "9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", day: "Freitag",isBlockLesson: false, datesForBlocklesson: []),
            
            
            
        //BLOCKLESSONS
            lessonModel(id: "3ddvefsfef", starttime: "11:30", endtime: "13:00", lessonName: "Robotiksblockstunde" ,room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik", day: "Freitag", isBlockLesson: true, datesForBlocklesson: [lessonDateDuration(date: Date(), durationInMinutes: 180)]),
            lessonModel(id: "9cecjeijidawd",starttime: "13:00", endtime: "19:00", lessonName: "Irendein langes Fach", room: "FG_023b", lecturer: "Prof. Dr. Christian Anderson", type: "Vortrag", addtional: "Einfach nur sehr lange Zeitverschwendung", day: "Freitag", isBlockLesson: true, datesForBlocklesson: [lessonDateDuration(date: Date(), durationInMinutes: 180)])
    ]
    }
}
