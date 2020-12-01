//
//  ScheduleView.swift
//  ScreensPart1
//
//  Created by MACBOOK on 01.12.20.
//

import SwiftUI
import UIKit
import Foundation

/**
 * The view housing all schedule related information in the form if lessons and block lessons
 */
struct ScheduleView: View {
    let days = ["Mo", "Di", "Mi", "Do", "Fr", "Sa"]
    @ObservedObject var scheduleViewModel = ScheduleViewModel()
    @State private var weekDay = 0
    
    var body: some View {
        VStack {
            VStack{
                HStack(alignment: .center){
                    Text("Stundenplan")
                        .font(.title)
                        .foregroundColor(Constants.textLight)
                        .bold()
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    Spacer()
                }.padding(EdgeInsets(top: 40, leading: 0, bottom: 10, trailing: 0))
            }.background(Constants.primaryDark)
                Picker(selection: $weekDay, label: Text("Wochentag")) {
                    ForEach((0..<days.count) , id:\.self){ index in
                        Text(days[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color(.white))
            GeometryReader { geo in
                ScrollView {
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessons.filter{lesson in return !lesson.isBlockLesson}) { lesson in
                            ScheduleRow(lesson: lesson, geometry : geo)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(width: .infinity, height: 1, alignment: .center)
                        Text("Blockstunden")
                            .font(.callout)
                            .bold()
                    }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessons.filter {lesson in return lesson.isBlockLesson}) { lesson in
                            BlockRow(lesson: lesson).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 100, trailing: 10))
                }
            }
        }.ignoresSafeArea(edges: .top)
    }
}

/**
  * Preview of the ScheduleView
 */
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleView()
        }
    }
}


/**
 * The whole row of regular scheduled lessons with all available data and a bullet point inf front of it
 */
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

/**
 * The vertical line in front of every lesson with a bullet point and the time data of the lesson
 */
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


/**
 * The lesson for display as a block lesson without bullet point
 */
struct BlockRow : View {
    var lesson : lessonModel
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
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            tapped.toggle()
        })
        .background(Constants.primaryLight).cornerRadius(10.0)
    }
}

/**
 * the majority of information about a specific lecture shown in a rounded rectangle to the trailing side of the lesson row
 */
struct LessonContent : View {
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
            }.padding(2)
            .onTapGesture(count: 1, perform: {
                tapped.toggle()
            })
            Spacer()
        }.padding(8)
        .background(Constants.primaryLight).cornerRadius(10.0)
    }
}
