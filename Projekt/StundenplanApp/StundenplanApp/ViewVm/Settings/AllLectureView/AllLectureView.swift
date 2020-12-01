//
//  AllLectureView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import SwiftUI

struct AllLectureView : View{
    @ObservedObject var viewModel : AllLectureViewModel
    
    var body: some View{
        VStack{
            if viewModel.dataIsAvailable{
                List(viewModel.data,id: \.lectureSelection.lecture.id){ data in
                    VStack{
                        Text(data.lectureSelection.lecture.label)
                        Text(data.lectureSelection.lecture.day)
                        Text(data.lectureSelection.lecture.starttime)
                        Text(data.lectureSelection.lecture.endtime)
                        Text("\(data.lectureSelection.courseName) - \(data.lectureSelection.semester)")
                        if data.selected{
                            Image(systemName: "hand.point.left.fill")
                        }
                    }.onTapGesture {
                        viewModel.updateScheduleSelection(lectureSelection: data.lectureSelection)
                    }
                }
            }
            else{
                Text("Loading...")
            }
        }.onAppear{
            viewModel.loadData()
        }
    }
}
