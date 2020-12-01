//
//  ContentView.swift
//  ScreensPart1
//
//  Created by MACBOOK on 10.11.20.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    var body: some View {
        TabView {
            ScheduleView()
             .tabItem {
                Image(systemName: "calendar")
                Text("Stundenplan")
              }
            Text("Stundenplanänderungen")
             .tabItem {
                Image(systemName: "calendar.badge.minus")
                Text("Änderungen")
              }
            Text("Einstellungen")
             .tabItem {
                Image(systemName: "wrench")
                Text("Einstellungen")
              }
        }.accentColor(Constants.primaryDark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
