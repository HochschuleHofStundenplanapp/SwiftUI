//
//  AllCoursesView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct AllCoursesView : View {
    
    @ObservedObject var viewModel : AllCoursesViewModel
    
    var body: some View{
        VStack {
        if(viewModel.dataisAvailable) {
            List(viewModel.data, id: \.course.course) { courseTuple in
                    HStack {
                        Text(courseTuple.course.course)
                        Spacer()
                        if courseTuple.selected {
                            Image(systemName: "checkmark")
                        }
                    }.contentShape(Rectangle()).onTapGesture {
                        viewModel.updateCourseSelection(course: courseTuple.course)
                    }
                }
            }
            else {
                Text("loading")
            }
        }.onAppear(perform: {
            viewModel.getCourses()
        }).navigationTitle("Studiengangwahl")
    }
}

struct AllCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCoursesView(viewModel: AllCoursesViewModel(term: "WS"))
    }
}
