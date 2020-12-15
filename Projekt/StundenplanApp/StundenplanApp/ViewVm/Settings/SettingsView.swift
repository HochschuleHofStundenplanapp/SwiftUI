//
//  SettingsView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct SettingsView : View{
    @ObservedObject var viewModel = SettingsViewModel()
    
    @State private var selectedTermIdx = 0
    //@State private var toggleCalendar : Bool = false
    //term data to send to server
    //let termData = ["SS","WS"]
    
    var body: some View{
        VStack{
            ColoredNavigationHeader(headerText: "Test")
            NavigationView{
                List{
                    Picker(selection: $selectedTermIdx, label: Text("Wähle ein Semester aus")) {
                        Text("Sommersemester").tag(0)
                        Text("Wintersemester").tag(1)
                    }.onChange(of: selectedTermIdx, perform: { _ in
                        viewModel.selectedTermIndex = selectedTermIdx
                        viewModel.onTermChanged()
                    }).pickerStyle(SegmentedPickerStyle());
                    
                    NavigationLink(destination:AllCoursesView(viewModel: AllCoursesViewModel(term: viewModel.termData[viewModel.selectedTermIndex]))){Text("Studiengang")}
                    NavigationLink(destination:AllSemesterView(viewModel: AllSemesterViewModel())){Text("Semester")}.disabled(!viewModel.allowedToAccessSemesters)
                    NavigationLink(destination:AllLectureView(viewModel: AllLectureViewModel())){Text("Vorlesungen")}.disabled(!viewModel.allowedToAccessLectures)
                    
                    Toggle(isOn: $viewModel.shouldSynchronizeWithCalendar){
                        Text("Synchronisieren mit Kalender")
                    }
                    
                    Text("App zurücksetzen")
                    Text("Über uns")
                    Text("Impressum")
                    
                }.onAppear{
                    viewModel.updateAllowedStates()
                }
            }.navigationBarTitle("").navigationBarHidden(true)
        }.navigationBarTitle("").navigationBarHidden(true)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
