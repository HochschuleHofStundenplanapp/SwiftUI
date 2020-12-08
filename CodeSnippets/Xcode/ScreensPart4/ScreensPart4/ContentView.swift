//
//  ContentView.swift
//  ScreensPart4
//
//  Created by Xiongwei Zheng on 24.11.20.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var coursesVM = CoursesViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Einstellung")
                    .bold().font(.title)
                    .foregroundColor(Constants.foregroundColor)
                Spacer()
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title)
                }
            }.padding(5)
            .background(Constants.backgroundDark)
            List{
                ForEach(0 ..< coursesVM.allCourses.count){ count in
                    course(course: coursesVM.allCourses[count])
                }
            }
        }
    }
}

struct course : View {
    @State private var tapped = false
    
    var course : coursesModel
    
    var body: some View{
        HStack{
            Text(course.label)
            Spacer()
            if(tapped){
                Image(systemName: "plus.rectangle.fill")
            }
        }.onTapGesture {
            tapped.toggle()
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
