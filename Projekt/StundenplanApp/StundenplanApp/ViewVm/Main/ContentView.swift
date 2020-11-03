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
            Text("View 1").tabItem{
                Image(systemName: "triangle")
                Text("First")
            }
            Text("View 2").tabItem{
                Image(systemName: "circle")
                Text("Second")
            }
            Text("View 3").tabItem{
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
