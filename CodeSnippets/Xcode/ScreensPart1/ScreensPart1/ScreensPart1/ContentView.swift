//
//  ContentView.swift
//  ScreensPart1
//
//  Created by MACBOOK on 10.11.20.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteColor = 0
    var body: some View {
        NavigationView{
            VStack{
            HStack {
                Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                    Text("Mo").tag(0)
                    Text("Di").tag(1)
                    Text("Mi").tag(2)
                    Text("Do").tag(3)
                    Text("Fr").tag(4)
                    Text("Sa").tag(5)
                }.pickerStyle(SegmentedPickerStyle())
            }
                HStack {
                    Circle()
                    Text("8:00 - 9:30").font(.caption)
                }
            Text("Screens Part 1!")
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
