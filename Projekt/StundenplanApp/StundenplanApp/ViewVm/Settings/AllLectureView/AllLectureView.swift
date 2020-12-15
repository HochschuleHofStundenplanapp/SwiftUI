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
                ScrollView{
                    LazyVStack{
                        ForEach(viewModel.data,id: \.lectureSelection.lecture.id){ data in
                            LectureSelectionRow(lectureSelectionTuple: data).onTapGesture {
                                viewModel.updateScheduleSelection(lectureSelection: data.lectureSelection)
                            }
                        }
                    }
                }
            }
            else{
                Text("Loading...")
            }
        }.onAppear{
            viewModel.loadData()
        }.onDisappear{
            //TODO: save data?
            print("Called on disappear")
        }.navigationBarTitle(Text("Vorlesungswahl"), displayMode: .inline)
    }
}
