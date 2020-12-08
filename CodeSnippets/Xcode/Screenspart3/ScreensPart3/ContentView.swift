//
//  ContentView.swift
//  ScreensPart3
//
//  Created by Georg Hauschild on 10.11.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var pick = 1
    @State private var isToggle : Bool = true
    
    
    var body: some View {
        
        NavigationView(){
            
            List{
                Picker(selection: $pick, label: Text("Wähle ein Semester aus")) {
                    Text("Sommersemester").tag(0)
                    Text("Wintersemester").tag(1)
                }.pickerStyle(SegmentedPickerStyle());
                
                NavigationLink(destination:Text("test")){VStack{
                    Text("Studiengang  ")
                    Text("Mobile Computing").font(.system(size: 12))
                }}
                NavigationLink(destination:Text("test")){VStack{
                    Text("Semester     ")
                    Text("5. Fachsemester").font(.system(size: 12))
                    
                }}
                NavigationLink(destination:Text("test")){Text("Vorlesungen")}
                
                Toggle(isOn: $isToggle){
                    Text("Synchronisieren mit Kalender")
                }
                
                Text("App zurücksetzen")
                Text("Über uns")
                Text("Impressum")
                
            }.navigationTitle("Einstellungen")
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
