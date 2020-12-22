//
//  ChangesFetcher.swift
//  StundenplanApp
//
//  Created by Eric Münch on 22.12.20.
//

import Combine

class ChangesFetcher : ObservableObject{
    
    //fields
    private var cancel : AnyCancellable? = nil
    private let userModel = UserModel()
    
    @Published var hasChanged = false
    
    //functions
    func fetchAndUpdateChanges(){
        userModel.changes.removeAll()
        cancel = Pipelines()
            .getChangesForSelectedCourseSemester(courseSemesters: userModel.semesters, term: userModel.term)
            .sink(receiveCompletion: { _ in
                self.hasChanged = true
            }, receiveValue: { value in
                let userAjustedChanges = self.filterChangesBySelectedLectures(changes: value.changes)
                self.userModel.changes.append(contentsOf: userAjustedChanges)
            })
    }
    
    private func filterChangesBySelectedLectures(changes : [Change]) -> [Change]{
        let selectedLectureParams = userModel
            .lectureSelections
            .map{
                (label: $0.lecture.label, day: $0.lecture.day, startTime : $0.lecture.starttime)
            }
        return changes.filter{ch in
            selectedLectureParams.contains{ params in
                params.label == ch.label && params.day == ch.original.day && params.startTime == ch.original.time
            }
        }
    }
}
