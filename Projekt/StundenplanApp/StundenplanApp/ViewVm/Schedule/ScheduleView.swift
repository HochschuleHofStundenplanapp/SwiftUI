//
//  ScheduleView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct ScheduleView : View {
    //let days = ["Mo", "Di", "Mi", "Do", "Fr", "Sa"]
    @ObservedObject var scheduleViewModel = ScheduleViewModel()
    @State private var selectedDayIdx = 0
    
    var body: some View {
        VStack {
            ColoredNavigationHeader(headerText: "Stundenplan")
            Picker(selection: $selectedDayIdx, label: Text("Wochentag")) {
                ForEach((0..<scheduleViewModel.days.count) , id:\.self){ index in
                    Text(scheduleViewModel.days[index].prefix(2)).tag(index)
                }
            }.onChange(of: selectedDayIdx, perform: { _ in
                scheduleViewModel.updateDaySelection(dayIdx: selectedDayIdx)
            })
            .pickerStyle(SegmentedPickerStyle())
            .background(Color(.white))
            GeometryReader { geo in
                ScrollView {
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessons.filter{lesson in return !lesson.isBlockLecture() && lesson.day.starts(with:scheduleViewModel.days[selectedDayIdx])}) { lesson in
                            ScheduleRow(lesson: lesson, geometry : geo)
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    if(scheduleViewModel.lessons.filter{lesson in return lesson.isBlockLecture()}.count > 0){
                        VStack(alignment: .leading){
                            Rectangle()
                                .frame(width: .infinity, height: 1, alignment: .center)
                            Text("Blockstunden")
                                .font(.callout)
                                .bold()
                        }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    }
                    
                    LazyVStack(spacing:0) {
                        ForEach (scheduleViewModel.lessons.filter {lesson in return lesson.isBlockLecture()}) { lesson in
                            BlockRow(lesson: lesson).padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                        }
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 100, trailing: 10))
                }
            }
        }.ignoresSafeArea(edges: .top)
        .onAppear(perform: scheduleViewModel.loadLessons)
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
 * The lesson for display as a block lesson without bullet point
 */
struct BlockRow : View {
    var lesson : Lecture
    @State private var tapped = false
    
    static let shortFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    
    var body : some View {
        HStack {
            VStack(alignment: .leading){
                Text(self.lesson.label).bold()
                    .font(.caption)
                //Used to list all block lectures
                /*ForEach(self.lesson.datesForBlocklesson, id: \.id){ dateDuration in
                 HStack{
                 Text("\(self.lesson.starttime) - \(self.lesson.endtime)")
                 .font(.caption)
                 Text("\(dateDuration.date, formatter: BlockRow.shortFormat)")
                 .font(.caption)
                 Text("\(dateDuration.durationInMinutes) min")
                 .font(.caption)
                 }
                 }*/
                HStack{
                    Text(self.lesson.room)
                        .font(.caption)
                    Text(self.lesson.group)
                        .font(.caption)
                }
                Text(self.lesson.docent)
                    .font(.caption)
                if(tapped){
                    VStack(alignment: .leading){
                        Text(self.lesson.comment).font(.caption)
                        Text(self.lesson.style).font(.caption)
                        Text(self.lesson.type).font(.caption)
                    }
                }
            }
            Spacer()
        }.padding(10)
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            tapped.toggle()
        })
        .background(ColorConstants.primaryLight).cornerRadius(10.0)
    }
}

struct ScheduleRow:View{
    var lesson:Lecture
    var geometry : GeometryProxy
    
    var body: some View{
        HStack {
            BulletLine()
            Text("\(self.lesson.starttime) - \(self.lesson.endtime)")
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
 * the majority of information about a specific lecture shown in a rounded rectangle to the trailing side of the lesson row
 */
struct LessonContent : View {
    var lesson : Lecture
    @State private var tapped = false
    var body : some View {
        HStack {
            VStack(alignment: .leading){
                Text(self.lesson.label).bold()
                    .font(.caption)
                Text(self.lesson.room)
                    .font(.caption)
                Text(self.lesson.docent)
                    .font(.caption)
                if(tapped){
                    VStack(alignment: .leading){
                        Text(self.lesson.comment).font(.caption)
                        Text(self.lesson.type).font(.caption)
                        Text(self.lesson.style).font(.caption)
                    }
                }
            }.padding(2)
            .onTapGesture(count: 1, perform: {
                tapped.toggle()
            })
            Spacer()
        }.padding(8)
        .background(ColorConstants.primaryLight).cornerRadius(10.0)
    }
}

