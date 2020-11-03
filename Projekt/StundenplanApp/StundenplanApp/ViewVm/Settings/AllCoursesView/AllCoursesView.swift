//
//  AllCoursesView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct AllCoursesView : View {
    
    var term : String
    @ObservedObject var viewModel : AllCoursesViewModel
    
    //course of studies
    @State private var courses:[String] = []
    @State private var selectedCourse = 0
    
    //available semesters
    @State private var semesters:[String] = []
    @State private var selectedSemester = 0
    
    var body: some View{
        VStack {
            Text("Wähle einen Studiengang").font(.title)
            if(viewModel.dataisAvailable){
                Picker(selection: $selectedCourse, label:     Text("Select a course of studies")){
                    ForEach( 0 ..< viewModel.data.count){
                        Text(viewModel.data[$0].course)
                    }
                }.onChange(of: self.selectedCourse, perform: { value in
                    print("selected Course: \(value)")
                    if(value > 0){
                        semesters = viewModel.data[value].semester
                    } else{
                        semesters = []
                    }
                })
                
            }else{
                Text("Loading")
            }
            
            if(selectedCourse > 0 && viewModel.dataisAvailable){
                Text("Wähle ein Semester").font(.title)
                Picker(selection: $selectedSemester, label:     Text("Select a course of studies")){
                    ForEach( 0 ..< semesters.count,id: \.self){
                        Text(self.semesters[$0])
                    }
                }
            }
            
            if(selectedCourse > 0 && selectedSemester > 0){
                NavigationLink( destination: Text("Not implemented yet") ){
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

struct AllCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCoursesView(term: "WS", viewModel: AllCoursesViewModel())
    }
}
