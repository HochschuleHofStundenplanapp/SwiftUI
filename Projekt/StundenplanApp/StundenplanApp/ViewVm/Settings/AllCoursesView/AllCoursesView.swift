//
//  AllCoursesView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct AllCoursesView : View {
    
    @ObservedObject var viewModel : AllCoursesViewModel
    @State var selectedCourses: [Course] = []
    
    var body: some View{
        VStack {
        if(viewModel.dataisAvailable) {
            List(viewModel.data, id: \.course) { course in
                HStack {
                    Text(course.course).onTapGesture(perform: {
                        if selectedCourses.contains(where: {$0.course == course.course}) {
                            selectedCourses.removeAll(where: {$0.course == course.course})
                            viewModel.selectedCourses.removeAll(where: {$0.course == course.course})
                        } else {
                            viewModel.selectedCourses.append(course)
                            selectedCourses.append(course)
                        }
                    })
                    if selectedCourses.contains(where: {$0.course == course.course}) {
                        Image(systemName: "hand.point.left.fill")
                    }
                }
        }
        } else {
            Text("loading")
        }
            
        }.onAppear(perform: {
            viewModel.getCourses()
        })
    }
}

struct AllCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        AllCoursesView(viewModel: AllCoursesViewModel(term: "WS"))
    }
}
