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
    
    let days = ["Montag","Dienstag","Mittwoch","Donnerstag","Freitag","Samstag"]
    var selectedDayIndex = 0
    
    @Published var dataIsAvalible = false
    
    ///all lessons available to the schedule, including block lessons
    @Published var lessons:[Lecture] = []
    
    
    //functions
    func updateDaySelection(dayIdx: Int){
        selectedDayIndex = dayIdx
        //TODO: Data change
    }
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
        
        lessons = UserModel().lectureSelections.map{$0.lecture}
        /*
        lessons = [
            //REGULAR LESSONS
            Lecture(id: "2dfefscdsc",label: "Montagsarchitektur mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Regelmäßig", group:"Gruppe B",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Montag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            Lecture(id: "gbtzhzh",label: "Dienstagsarchitektur mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Regelmäßig", group:"Gruppe B",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Dienstag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            Lecture(id: "3fvrgdg",label: "Mittwochsarchitektur mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Regelmäßig", group:"Gruppe B",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Mittwoch", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            Lecture(id: "77gsevvvv",label: "Donnerstagsarchitektur mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Regelmäßig", group:"Gruppe B",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Donnerstag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            Lecture(id: "787rfvvrbhh",label: "Freitagsarchitektur mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Regelmäßig", group:"Gruppe A",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Freitag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            //BLOCK
            Lecture(id: "wdakjwbd7",label: "Blockvorlesung mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Blockunterricht", group:"Gruppe Y",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Dienstag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
            Lecture(id: "d3fevrvd",label: "Blockvorlesung mobiler Anwendungen", docent: "Prof. Dr. Peter Stöhr", type: "Frontalunterricht", style: "Blockunterricht", group:"Gruppe B",starttime: "8:00", endtime: "9:30", startdate:"12.12.12", enddate: "12.12.12",day: "Samstag", room: "virt_pstöhr", splusname: "???", comment: "Further Information concerning the lesson",sp: "??"),
        ]
 */
    }
}
