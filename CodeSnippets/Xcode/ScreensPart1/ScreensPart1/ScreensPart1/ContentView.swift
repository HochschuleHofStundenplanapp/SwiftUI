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
        lessonModel(time: "13:00 - 17:15", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik")
    ]
    
    var body: some View {
        NavigationView{
            VStack {
                Picker(selection: $weekDay, label: Text("Wochentag")) {
                    ForEach((0..<days.count) , id:\.self){ index in
                        Text(days[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                List(lessonsForWeekDay, id:\.id){ lesson in
                    ScheduleRow(lesson: lesson)
                }.listStyle(PlainListStyle())
            }.navigationTitle("Stundenplan")
        }
    }
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
            }.padding(EdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 0.0))
            Text(self.lesson.time)
                .font(.caption)
            VStack{
                VStack(alignment: .leading){
                    Text(self.lesson.lessonName).bold()
                        .font(.caption)
                    Text(self.lesson.room)
                        .font(.caption)
                    Text(self.lesson.lecturer)
                        .font(.caption)
                }
                if(tapped){
                    VStack(alignment: .leading){
                        Text(self.lesson.type).font(.caption)
                        Text(self.lesson.addtional).font(.caption)
                    }
                }
            }.padding(8)
            .background(backgroundColor).cornerRadius(10.0)
            .padding(20)
        }.onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            tapped.toggle()
        })
        .listRowInsets(.init(EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)))
    }
}

struct timeBlock{
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
