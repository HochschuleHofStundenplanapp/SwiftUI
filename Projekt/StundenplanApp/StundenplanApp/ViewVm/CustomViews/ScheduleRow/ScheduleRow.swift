//
//  ScheduleRow.swift
//  StundenplanApp
//
//  Created by Eric Münch on 08.12.20.
//

import SwiftUI

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

