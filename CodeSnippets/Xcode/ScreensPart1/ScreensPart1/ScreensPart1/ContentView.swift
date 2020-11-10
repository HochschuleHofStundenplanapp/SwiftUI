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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
