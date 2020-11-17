//
//  ContentView.swift
//  ScreensPart2
//
//  Created by Xiongwei Zheng on 10.11.20.
//

import SwiftUI

struct changesModel {
    var label: String
    var docent: String
    var reason: String
    var group: String
    var originalTime: String
    var originalDate: String
    var originalRoom: String
    var alternativeTime: String
    var alternativeDate: String
    var alternativeRoom: String
}

struct ContentView: View {
    var allChanges = [
        changesModel(label: "Architektur mobiler Anwendung", docent: "Prof. Dr. Stöhr", reason: "", group: "", originalTime: "14:00 - 15:00", originalDate: "13.10.2020", originalRoom: "FB004B", alternativeTime: "14:00 - 15:30", alternativeDate: "20.10.2020", alternativeRoom: "FB004B"),
        changesModel(label: "Robotik", docent: "Prof. Dr. Groth", reason: "entfällt", group: "", originalTime: "14:00 - 15:30", originalDate: "14.10.2020", originalRoom: "virt.cgroth", alternativeTime: "", alternativeDate: "", alternativeRoom: "")]
    
    let background = Color(red: 0.745, green:0.824, blue: 0.75, opacity: 100)
    var body: some View {
        NavigationView{
            List(){
                ChangesRow(changes: allChanges[0])
                ChangesRow(changes: allChanges[1])
                
            }.navigationBarTitle(Text("Changes"), displayMode: .inline)
            .background(Color.yellow)
            
        }
    }
}

struct ChangesRow: View {
    var changes : changesModel
    
    let background = Color(red: 0.745, green:0.824, blue: 0.75, opacity: 100)
    
    var body: some View{
        if self.changes.alternativeTime == "" && self.changes.alternativeDate == "" {
            VStack(alignment: .leading){
                HStack{
                    Text(self.changes.label)
                        .font(.title2)
                    Text("(" + self.changes.reason + ")").font(.title3)
                    Spacer()
                }.padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
            }
            .background(background)
            .cornerRadius(10.0)
            .padding(10)
        }else{
            VStack(alignment: .leading){
                Text(self.changes.label).font(.title2).padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeDate)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeRoom)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeTime)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.docent)
                        .font(.caption)
                }.padding(5)
            }
            .background(background)
            .cornerRadius(10.0)
            .padding(10)
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 //
 //  ContentView.swift
 //  ScreensPart1
 //
 //  Created by MACBOOK on 10.11.20.
 //
 import SwiftUI
 import UIKit
 import Foundation
 
 struct ContentView: View {
 
 @State private var weekDay = 0
 var lessonsForWeekDay = [lessonModel(time: "8:00 - 9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson"),
 lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik"),
 lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik")
 ]
 var body: some View {
 NavigationView{
 VStack{
 Text("Stundenplan")
 HStack {
 Picker(selection: $weekDay, label: Text("What is your favorite color?")) {
 Text("Mo").tag(0)
 Text("Di").tag(1)
 Text("Mi").tag(2)
 Text("Do").tag(3)
 Text("Fr").tag(4)
 Text("Sa").tag(5)
 }.pickerStyle(SegmentedPickerStyle()).padding()
 }
 List(){
 ScheduleRow(lesson: lessonsForWeekDay[0])
 ScheduleRow(lesson: lessonsForWeekDay[1])
 ScheduleRow(lesson: lessonsForWeekDay[2])
 }
 }
 }
 }
 }
 
 //dummy Data
 struct lessonModel {
 var time: String
 var lessonName: String
 var room: String
 var lecturer: String
 var type:String
 var addtional:String
 }
 
 struct ScheduleRow:View{
 let backgroundColor = Color(red: 0.745, green: 0.824, blue: 0.725, opacity: 100)
 var lesson:lessonModel
 @State var tapped = false
 
 var body: some View{
 HStack {
 ZStack{
 Rectangle().frame(width: 1, height: .infinity, alignment: .leading)
 Circle()
 .strokeBorder(Color.black,lineWidth: 1)
 .background(Circle().foregroundColor(Color.white))
 .frame(width: 10, height: 10)
 }
 Text(self.lesson.time)
 .font(.caption)
 VStack{
 HStack{
 Text(self.lesson.lessonName)
 .font(.caption)
 Spacer()
 }
 HStack{
 Text(self.lesson.room)
 .font(.caption)
 Spacer()
 Text(self.lesson.lecturer)
 .font(.caption)
 }
 if(tapped){
 Text(self.lesson.type).font(.caption)
 Text(self.lesson.addtional).font(.caption)
 }
 }.padding(8)
 .background(backgroundColor).cornerRadius(10.0)
 }
 }
 }
 */
