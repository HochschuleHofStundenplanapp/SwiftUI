//
//  AllLectureView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import SwiftUI

struct AllLectureView : View{
    @ObservedObject var viewModel : AllLectureViewModel
    
    @State var selectedDayIdx : Int = 0
    
    var body: some View{
        VStack{
            Picker(selection: $selectedDayIdx, label: Text("Wähle ein Semester aus")) {
                ForEach(0..<viewModel.days.count){index in
                    Text(viewModel.days[index].prefix(2)).tag(index)
                }
            }.onChange(of: selectedDayIdx, perform: { _ in
                viewModel.updateDaySelection(dayIdx: selectedDayIdx)
            }).pickerStyle(SegmentedPickerStyle());
            if viewModel.dataIsAvailable{
                List(viewModel.data,id: \.lectureSelection.lecture.id){ data in
                    /*VStack{
                        Text(data.lectureSelection.lecture.label)
                        Text(data.lectureSelection.lecture.day)
                        Text(data.lectureSelection.lecture.starttime)
                        Text(data.lectureSelection.lecture.endtime)
                        Text("\(data.lectureSelection.courseName) - \(data.lectureSelection.semester)")
                        if data.selected{
                            Image(systemName: "checkmark")
                        }
                    }*/
                    LectureSelectionRow(lectureSelectionTuple: data).onTapGesture {
                        viewModel.updateScheduleSelection(lectureSelection: data.lectureSelection)
                    }
                }
            }
            else{
                Text("Loading...")
            }
        }.onAppear{
            viewModel.loadData()
        }.navigationBarTitle(Text("Vorlesungswahl"), displayMode: .inline)
    }
}
