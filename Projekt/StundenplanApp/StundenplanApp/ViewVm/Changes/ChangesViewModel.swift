//
//  ChangesViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 22.12.20.
//

import Combine

class ChangesViewModel : ObservableObject{
    //fields
    @Published var dataIsAvailable = false
    var allChanges = [Change]()
    
    var cancel : AnyCancellable? = nil
    private let serverModel = ServerModel()
    private let userModel = UserModel()
    
    //functions
    func getChanges(){
        //TODO
        
        if userModel.semesters.isEmpty{
            return
        }
        fetchDataFromApi()
    }
    
    private func fetchDataFromApi(){
        allChanges.removeAll()
        serverModel.changes.removeAll()
        cancel = Pipelines()
            .getChangesForSelectedCourseSemester(courseSemesters: userModel.semesters, term: userModel.term)
            .sink(receiveCompletion: {(_) in
                self.dataIsAvailable = true
            }, receiveValue: { [self] (value) in
                self.allChanges.append(contentsOf: value.changes)
                serverModel.changes.append(contentsOf: value.changes)
            })
    }
}
