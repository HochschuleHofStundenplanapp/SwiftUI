//
//  SettingsView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct SettingsView : View{
    @State private var selected = 0
    
    //term data to send to server
    let termData = ["SS","WS"]
    
    var body: some View{
        NavigationView{
            VStack {
                Picker(selection: $selected, label: Text("WS/SS")) {
                    ForEach(0..<termData.count) {index in
                        Text(self.termData[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                NavigationLink(destination: AllCoursesView(viewModel: AllCoursesViewModel(term: termData[selected]))) {
                    Text("Studiengang")
                }
                Text("")
                Button(action: {}, label: {
                    Text("Semester")
                })
                Text("")
                Button(action: {}, label: {
                    Text("Vorlesungen")
                })
                Text("")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
