//
//  ChangesViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 22.12.20.
//

import Combine

class ChangesViewModel : ObservableObject{
    //fields
    @Published var dataIsAvailable = true
    var allChanges = [Change]()
    
    var subscription : AnyCancellable? = nil
    
    private var changeFetcher = ChangesFetcher()
    private let serverModel = ServerModel()
    private let userModel = UserModel()
    
    //init
    init(){
        subscription = userModel.modelNotifier().sink{
            print("usermodel notification")
            self.allChanges = self.userModel.changes
            self.dataIsAvailable = true
        }
    }
    
    //functions
    func getChanges(){
        if userModel.semesters.isEmpty{
            return
        }
        changeFetcher.fetchAndUpdateChanges()
    }
}
