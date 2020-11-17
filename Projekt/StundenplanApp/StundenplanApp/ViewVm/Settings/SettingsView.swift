//
//  SettingsView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct SettingsView : View{
    @State private var selected = 0
    @ObservedObject var viewModel = SettingsViewModel()
    //term data to send to server
    //let termData = ["SS","WS"]
    
    var body: some View{
        NavigationView{
            VStack {
                Picker(selection: $selected, label: Text("WS/SS")) {
                    ForEach(0..<viewModel.termData.count) {index in
                        Text(self.viewModel.termData[index]).tag(index)
                    }
                }.onChange(of: selected, perform: { _ in
                    viewModel.selectedTermIndex = selected
                    viewModel.onTermChanged()
                }).pickerStyle(SegmentedPickerStyle())
                NavigationLink(destination: AllCoursesView(viewModel: AllCoursesViewModel(term: viewModel.termData[viewModel.selectedTermIndex]))) {
                    Text("Studiengang")
                }
                Text("")
                NavigationLink(destination: AllSemesterView(viewModel: AllSemesterViewModel())) {
                    Text("Semester")
                }
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
