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
    let days = ["Mo", "Di", "Mi", "Do", "Fr", "Sa"]
    
    @State private var weekDay = 0
    var lessonsForWeekDay = [
        lessonModel(time: "8:00 - 9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson"),
        lessonModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik"),
        lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik"),
        lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik"),
        lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik"),
        lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik")
    ]
    
    var body: some View {
        VStack {
            VStack(alignment: .center){
                Text("Stundenplan").font(.title).bold()
            }
            Picker(selection: $weekDay, label: Text("Wochentag")) {
                ForEach((0..<days.count) , id:\.self){ index in
                    Text(days[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            GeometryReader { geo in
                ScrollView {
                    LazyVStack(spacing:0) {
                        ForEach (lessonsForWeekDay) { lesson in
                            ScheduleRow(lesson: lesson, geometry : geo)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
        }.navigationTitle("Stundenplan")
    }
}

struct ScheduleRow:View{
    var lesson:lessonModel
    var geometry : GeometryProxy
    
    var body: some View{
        HStack {
            BulletLine()
            Text(self.lesson.time)
                .font(.caption)
                .frame(width: geometry.size.width / 4.0, alignment : .leading)
            LessonContent(lesson: lesson).padding(2)
        }
    }
}

struct BulletLine : View {
    var body : some View {
        ZStack{
            Rectangle().frame(width: 1, height: .infinity, alignment: .leading)
            Circle()
                .strokeBorder(Color.black,lineWidth: 1)
                .background(Circle().foregroundColor(Color.white))
                .frame(width: 10, height: 10)
        }
    }
    
}

struct LessonContent : View {
    let backgroundColor = Color(red: 0.745, green: 0.824, blue: 0.725, opacity: 100)
    var lesson : lessonModel
    @State private var tapped = false
    var body : some View {
        HStack {
            VStack(alignment: .leading){
                Text(self.lesson.lessonName).bold()
                    .font(.caption)
                Text(self.lesson.room)
                    .font(.caption)
                Text(self.lesson.lecturer)
                    .font(.caption)
                if(tapped){
                    VStack(alignment: .leading){
                        Text(self.lesson.type).font(.caption)
                        Text(self.lesson.addtional).font(.caption)
                    }
                }
            }.onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                tapped.toggle()
            })
            Spacer()
        }.padding(8)
        .background(backgroundColor).cornerRadius(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
