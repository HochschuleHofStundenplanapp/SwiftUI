//
//  ContentView.swift
//  UIDetails
//
//  Created by MACBOOK on 27.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    @State private var terms:[String] = ["-","Sommersemester", "Wintersemester"]
    @State private var selected = 0
    
    //term data to send to server
    let termData = ["SS","WS"]
    
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Wähle eine Vorlesungszeit").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Picker(selection: $selected, label:     Text("Select a term")){
                    ForEach( 0 ..< terms.count){
                        Text(self.terms[$0])
                    }
                }
                if(selected > 0){
                NavigationLink(destination: SecondView(term: termData[selected - 1]) ){
                        Text("Next").font(.title)
                }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct SecondView: View{
    
    var term:String
    
    //course of studies
    @State private var courses:[String] = []
    @State private var selectedCourse = 0
    
    //available semesters
    @State private var semesters:[String] = []
    @State private var selectedSemester = 0
    
    var body: some View{
        VStack {
            Text("Wähle einen Studiengang").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Picker(selection: $selectedCourse, label:     Text("Select a course of studies")){
                ForEach( 0 ..< courses.count){
                    Text(self.courses[$0])
                }
            }
            
            Text("Wähle ein Semester").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Picker(selection: $selectedSemester, label:     Text("Select a course of studies")){
                ForEach( 0 ..< semesters.count){
                    Text(self.semesters[$0])
                }
            }.onChange(of: selectedCourse, perform: { value in
                //fetch semesters for parameter
                //term + course (?)
            })
            
            if(selectedCourse > 0 && selectedSemester > 0){
            NavigationLink( destination: ThirdView(term:  term, courseOfStudies: courses[selectedCourse], semester: semesters[selectedSemester] ) ){
                Text("Next").font(.title)
            }.buttonStyle(PlainButtonStyle())
            }
            
        }.onAppear(perform: {
            //Fetch available courses and semesters using one parameter
            //term
        })
    }
}

struct ThirdView: View{
    var term: String
    var courseOfStudies: String
    var semester: String
    
    var body: some View{
        VStack{
            Text("Lesson")
        }.onAppear(perform: {
            //fetch courses via all three parameters
            //term + course of studies + semester
        })
    }
}

struct ListElement: View {
    // list element
    var body: some View{
        Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
