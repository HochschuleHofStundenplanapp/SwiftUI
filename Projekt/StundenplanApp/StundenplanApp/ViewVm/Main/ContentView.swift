//
//  ContentView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    
    var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        TabView{
            ScheduleView().tabItem{
                Image(systemName: "calendar")
                Text("Stundenplan")
            }
            ChangesView().tabItem{
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
