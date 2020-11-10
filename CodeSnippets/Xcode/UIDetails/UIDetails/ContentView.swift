//
//  ContentView.swift
//  UIDetails
//
//  Created by MACBOOK on 27.10.20.
//

import SwiftUI
import CoreData
import Combine
import Foundation

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
                Picker(selection: $selected, label: Text("Select a term")){
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
    
    @ObservedObject var viewModel = SecondViewModel()
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
            if(viewModel.dataisAvailable){
                Picker(selection: $selectedCourse, label:     Text("Select a course of studies")){
                    ForEach( 0 ..< viewModel.data.count){
                        Text(viewModel.data[$0].course)
                    }
                }.onChange(of: self.selectedCourse, perform: { value in
                    print("selected Course: \(value)")
                    if(value > 0){
                        semesters.append(contentsOf: viewModel.data[value].semester)
                    } else{
                        semesters = []
                    }
                })
                
            }else{
                Text("Loading")
            }
            
            if(selectedCourse > 0 && viewModel.dataisAvailable){
                Text("Wähle ein Semester").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Picker(selection: $selectedSemester, label:     Text("Select a course of studies")){
                    ForEach( 0 ..< semesters.count){
                        Text(self.semesters[$0])
                    }
                }
            }
            
            if(selectedCourse > 0 && selectedSemester > 0){
                NavigationLink( destination: ThirdView(term:  term, courseOfStudies: courses[selectedCourse], semester: semesters[selectedSemester] ) ){
                    Text("Next").font(.title)
                }.buttonStyle(PlainButtonStyle())
            }
            
        }.onAppear(perform: {
            
            viewModel.getCourses(term: term)
            //Fetch available courses and semesters using one parameter
            //term
        })
    }
}

class SecondViewModel : ObservableObject {
    @Published var dataisAvailable: Bool = false
    var data: [Course] = []
    var cancel: AnyCancellable? = nil
    
    func getCourses(term: String) {
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getCoursesAfterTerm(term: term).sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            self.data = value.courses
        })
    }
}

struct ThirdView: View{
    var term: String
    var courseOfStudies: String
    var semester: String
    
    var body: some View{
        VStack{
            Text("Stundenplan")
            
        }.onAppear(perform: {
            //fetch courses via all three parameters
            //term + course of studies + semester
        })
    }
}

struct ScheduleElement: View {
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
