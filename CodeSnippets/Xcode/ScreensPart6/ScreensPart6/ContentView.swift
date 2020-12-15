//
//  ContentView.swift
//  ScreensPart6
//
//  Created by Xiongwei Zheng on 01.12.20.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    
    
    let days = ["Mo", "Di", "Mi", "Do", "Fr", "Sa"]
    @ObservedObject var scheduleViewModel = LectureViewModel()
    @State private var weekDay = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Lectures").font(.title).bold()
                Spacer()
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title)
                }
            }.padding(5)
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Alles Auswählen")
                        .foregroundColor(Constants.foregroundColor)
                })
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Alles Abwählen")
                        .foregroundColor(Constants.foregroundColor)
                })
            }
            .padding(5)
            .background(Constants.gray)
            
            
            Picker(selection: $weekDay, label: Text("Wochentag")) {
                ForEach((0..<days.count) , id:\.self){ index in
                    Text(days[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            GeometryReader { geo in
                ScrollView {
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessonsForWeekDay.filter{lesson in return !lesson.isBlockLesson}) { lesson in
                            ScheduleRow(lesson: lectureModel, geometry : geo)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                        Text("Blockstunden")
                            .font(.callout)
                            .bold()
                    }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessonsForWeekDay.filter {lesson in return lesson.isBlockLesson}) { lesson in
                            BlockRow(lesson: lectureModel).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 100, trailing: 10))
                }
            }
        }.navigationTitle("Stundenplan")
    }
}

struct ScheduleRow:View{
    var lesson : lectureModel
    var geometry : GeometryProxy
    
    var body: some View{
        LessonContent(lesson: lesson)
            .padding(5)
    }
}

struct BlockRow : View {
    var lesson : lectureModel
    @State private var tapped = false
    
    static let shortFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var body : some View {
        HStack {
            VStack(alignment: .leading){
                Text(self.lesson.lessonName).bold()
                    .font(.caption)
                ForEach(self.lesson.datesForBlocklesson, id: \.id){ dateDuration in
                    HStack{
                        Text(self.lesson.time)
                            .font(.caption)
                        Text("\(dateDuration.date, formatter: BlockRow.shortFormat)")
                            .font(.caption)
                        Text("\(dateDuration.durationInMinutes) min")
                            .font(.caption)
                    }
                }
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
            }
            Spacer()
        }.padding(10)
        .background(Constants.backgroundColor).cornerRadius(10.0)
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            tapped.toggle()
        })
    }
}

struct LessonContent : View {
    var lesson : lectureModel
    @State private var tapped = false
    var body : some View {
        HStack {
            VStack(alignment: .leading){
                Text(self.lesson.lessonName).bold()
                    .font(.caption)
                    .padding(1)
                if(tapped){
                    HStack{
                        Text(self.lesson.comment)
                            .font(.caption)
                            .padding(1)
                        Spacer()
                        Image(systemName: "plus.rectangle.fill")
                    }
                }else{
                    Text(self.lesson.comment)
                        .font(.caption)
                        .padding(1)
                }
                Text(self.lesson.time)
                    .font(.caption)
                    .padding(1)
                HStack{
                    Text(self.lesson.room)
                        .font(.caption)
                    Spacer()
                    Text(self.lesson.lecturer)
                        .font(.caption)
                }
                .padding(1)
            }.padding(2)
            Spacer()
        }.padding(8)
        .background(Constants.backgroundColor).cornerRadius(10.0)
        .onTapGesture(count: 1, perform: {
            tapped.toggle()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
