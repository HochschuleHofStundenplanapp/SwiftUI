//
//  SettingsViewModel.swift
//  StundenplanApp
//
//  Created by Eric Münch on 17.11.20.
//

import Foundation

class SettingsViewModel : ObservableObject{
    //term data to send to server
    let termData = ["SS","WS"]
    var selectedTermIndex = 0
    @Published var shouldSynchronizeWithCalendar = false
    
    @Published var allowedToAccessSemesters : Bool = false
    @Published var allowedToAccessLectures : Bool = false
    
    //model access
    private let serverModel : ServerModel = ServerModel()
    private var settingsModel : SettingsModel = SettingsModel()
    
    init() {
        syncModels()
    }
    
    func syncModels() {
        UserModel().copyTo(model: settingsModel)
    }
    
    //functions
    func onTermChanged(){
        serverModel.termChangeCleanup()
        settingsModel.termChangeCleanup()
        settingsModel.term = termData[selectedTermIndex]
        updateAllowedStates()
    }
    
    //function is exexcuted if view is appearing
    func updateAllowedStates(){
        allowedToAccessSemesters = !settingsModel.courses.isEmpty
        allowedToAccessLectures = settingsModel.hasSemesters()
        
        print("DEBUG:\nSemesters:\n\(settingsModel.semesters)\n\n")
    }
}
