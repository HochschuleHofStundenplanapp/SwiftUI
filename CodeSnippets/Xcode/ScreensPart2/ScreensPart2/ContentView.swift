//
//  ContentView.swift
//  ScreensPart2
//
//  Created by Xiongwei Zheng on 10.11.20.
//

import SwiftUI

struct changesModel {
    var label: String
    var docent: String
    var reason: String
    var group: String
    var originalTime: String
    var originalDate: String
    var originalRoom: String
    var alternativeTime: String
    var alternativeDate: String
    var alternativeRoom: String
}

struct ContentView: View {
    var allChanges =
        [changesModel(label: "Architektur mobiler Anwendung", docent: "Prof. Dr. Stöhr", reason: "", group: "", originalTime: "14:00 - 15:00", originalDate: "13.10.2020", originalRoom: "FB004B", alternativeTime: "14:00 - 15:30", alternativeDate: "20.10.2020", alternativeRoom: "FB004B"),
        changesModel(label: "Robotik", docent: "Prof. Dr. Groth", reason: "entfällt", group: "", originalTime: "14:00 - 15:30", originalDate: "14.10.2020", originalRoom: "virt.cgroth", alternativeTime: "", alternativeDate: "", alternativeRoom: "")]
    
    let background = Color(red: 0.745, green:0.824, blue: 0.75, opacity: 100)
    var body: some View {
        ScrollView(){
            ChangesRow(changes: allChanges[0])
            ChangesRow(changes: allChanges[1])
        }
        .navigationTitle("Changes")
        .padding(10)
    }
}

struct ChangesRow: View {
    var changes : changesModel
    
    let background = Color(red: 0.745, green:0.824, blue: 0.75, opacity: 100)
    
    var body: some View{
        if self.changes.alternativeTime == "" && self.changes.alternativeDate == "" {
            VStack(alignment: .leading){
                HStack{
                    Text(self.changes.label)
                        .font(.headline)
                    Text("(" + self.changes.reason + ")").font(.subheadline)
                    Spacer()
                }.padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
            }
            .padding(10)
            .background(background)
            .cornerRadius(10.0)
            
        }else{
            VStack(alignment: .leading){
                Text(self.changes.label).font(.headline).padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeDate)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeTime)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeRoom)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.docent)
                        .font(.caption)
                }.padding(5)
            }
            .padding(10)
            .background(background)
            .cornerRadius(10.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
