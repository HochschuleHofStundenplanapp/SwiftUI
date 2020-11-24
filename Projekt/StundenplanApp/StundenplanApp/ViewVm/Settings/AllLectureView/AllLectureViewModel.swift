//
//  AllLectureViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import SwiftUI
import Combine

class AllLectureViewModel : ObservableObject{
    @Published var dataIsAvalible = false
    var data = [ScheduleSelection]()
    
    private var cancel : AnyCancellable? = nil
    private let userModel = UserModel()
    private let serverModel = ServerModel()
    
    func loadData(){
        cancel = Pipelines()
            .getLecturesForSelectedCourseSemester(courseSemesters: userModel.semesters, term: userModel.term)
            .print()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {result in
                print("\(result)")
            },
            receiveValue: {select in
                print("\(select)")
            })
        dataIsAvalible = true
    }
}
