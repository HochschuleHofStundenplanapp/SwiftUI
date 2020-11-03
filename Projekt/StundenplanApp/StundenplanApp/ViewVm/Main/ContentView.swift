//
//  ContentView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ScheduleView().tabItem{
                Image(systemName: "triangle")
                Text("Schedule")
            }
            ChangesView().tabItem{
                Image(systemName: "circle")
                Text("Changes")
            }
            SettingsView().tabItem{
                Image(systemName: "square")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
