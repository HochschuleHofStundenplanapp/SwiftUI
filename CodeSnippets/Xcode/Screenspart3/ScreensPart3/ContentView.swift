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
    @State private var isToggle2 : Bool = true
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            Text("     Einstellungen").font(Font.body.bold())
            
            
            List{
                Picker(selection: $pick, label: Text("Wähle ein Semester aus")) {
                    Text("Sommersemester").tag(0)
                    Text("Wintersemester").tag(1)
                }.pickerStyle(SegmentedPickerStyle());
                
                VStack{
                    Text("Studiengang  ")
                    Text("Mobile Computing").font(.system(size: 12))
                }
                VStack{
                    Text("Semester     ")
                    Text("5. Fachsemester").font(.system(size: 12))
                    
                }
                Text("Vorlesungen")
                
                Toggle(isOn: $isToggle){
                    Text("Synchronisieren mit Kalender")
                }
                Text("Termine")
                Toggle(isOn: $isToggle2){
                    Text("Termine im Widget anzeigen")
                }
                
                Text("App zurücksetzen")
                Text("Über uns")
                Text("Impressum")
                
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
