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
                Text("First")
            }
            ChangesView().tabItem{
                Image(systemName: "circle")
                Text("Second")
            }
            SettingsView().tabItem{
                Image(systemName: "square")
                Text("Third")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
