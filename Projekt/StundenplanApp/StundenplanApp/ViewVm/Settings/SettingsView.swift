//
//  SettingsView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct SettingsView : View{
    @State private var terms:[String] = ["-","Sommersemester", "Wintersemester"]
    @State private var selected = 0
    
    //term data to send to server
    let termData = ["SS","WS"]
    
    var body: some View{
        NavigationView{
            VStack {
                Text("Wähle eine Vorlesungszeit").font(.title)
                Picker(selection: $selected, label:     Text("Select a term")){
                    ForEach( 0 ..< terms.count){
                        Text(self.terms[$0])
                    }
                }
                if(selected > 0){
                NavigationLink(destination: AllCoursesView() ){
                        Text("Next").font(.title)
                }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
