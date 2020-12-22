//
//  ContentView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    
    let settingsViewModel = SettingsViewModel()
    let changesViewModel = ChangesViewModel()
    
    var body: some View {
        TabView{
            ScheduleView().tabItem{
                Image(systemName: "calendar")
                Text("Stundenplan")
            }
            ChangesView(viewModel: changesViewModel).tabItem{
                Image(systemName: "calendar.badge.minus")
                Text("Änderungen")
            }
            SettingsView(viewModel: settingsViewModel).tabItem{
                Image(systemName: "wrench")
                Text("Einstellungen")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
