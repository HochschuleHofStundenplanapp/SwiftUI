//
//  ContentView.swift
//  ScreensPart4
//
//  Created by Xiongwei Zheng on 24.11.20.
//

import SwiftUI

struct coursesModel {
    var label : String
}

struct ContentView: View {
    let foregroundColor = Color(UIColor(hue: 0.3, saturation: 0.44, brightness: 0.7, alpha: 1.0))
    
    var allCourses = [
        coursesModel(label: "Betriebswirtschaft"),
        coursesModel(label: "Medieninformatik"),
        coursesModel(label: "Mobile Computing"),
        coursesModel(label: "Textildesign"),
        coursesModel(label: "Wirtschaftsrecht")
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Einstellung")
                    .bold().font(.title)
                    .foregroundColor(foregroundColor)
                Spacer()
                Button(action: {
                    print("Edit button was tapped")
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title)
                }
            }.padding(5)
            .background(Color(.systemGray6))
            List{
                ForEach(0 ..< allCourses.count){ value in
                    course(courseModel: allCourses[value])
                }
            }
        }
    }
}

struct course : View {
    @State private var tapped = false
    
    var courseModel : coursesModel
    
    var body: some View{
        HStack{
            Text(courseModel.label)
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
