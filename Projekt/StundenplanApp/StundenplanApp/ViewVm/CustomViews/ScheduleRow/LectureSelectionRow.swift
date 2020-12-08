//
//  LectureSelectionRow.swift
//  StundenplanApp
//
//  Created by Eric Münch on 08.12.20.
//

import SwiftUI

struct LectureSelectionRow : View{
    let lectureSelectionTuple : (lectureSelection: LectureSelection, selected: Bool)
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading){
                    Text(lectureSelectionTuple.lectureSelection.lecture.label)
                    Text(lectureSelectionTuple.lectureSelection.lecture.comment)
                    Text("\(lectureSelectionTuple.lectureSelection.lecture.starttime) - \(lectureSelectionTuple.lectureSelection.lecture.endtime)")
                }
                Spacer()
                if lectureSelectionTuple.selected{
                    Image(systemName: "checkmark")
                }
            }
            Text("")
            HStack{
                Text(lectureSelectionTuple.lectureSelection.lecture.room)
                Spacer()
                Text(lectureSelectionTuple.lectureSelection.lecture.docent)
            }
        }
        .font(.caption)
        .padding()
        .background(ColorConstants.primaryLight)
        .cornerRadius(8)
        .padding()
    }
}

struct LectureSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        LectureSelectionRow(lectureSelectionTuple: (lectureSelection: LectureSelection(courseName: "Course 1", semester: "2", lecture: Lecture(id: "12", label: "sdfasdf", docent: "Max Mustermann", type: "sdfghnm", style: "asdfsd", group: "ysdf", starttime: "08:00", endtime: "09:45", startdate: "01.12.2020", enddate: "01.12.2020", day: "Monday", room: "virt_abach", splusname: "sdfghj", comment: "Hallo", sp: "sp")), selected: true))
    }
}
