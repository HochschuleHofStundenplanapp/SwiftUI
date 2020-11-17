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
    
    private let serverModel : ServerModel = ServerModel()
    private let userModel : UserModel = UserModel()
    
    //functions
    func onTermChanged(){
        serverModel.termChangeCleanup()
        userModel.termChangeCleanup()
        userModel.term = termData[selectedTermIndex]
    }
}
