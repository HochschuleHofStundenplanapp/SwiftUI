//
//  ContentView.swift
//  ScreensPart5
//
//  Created by Xiongwei Zheng on 01.12.20.
//

import SwiftUI

struct semesterModel {
    var semester : String
}

struct ContentView: View {
    @State private var tapped = false
    
    let foregroundColor = Color(UIColor(hue: 0.3, saturation: 0.44, brightness: 0.7, alpha: 1.0))
    
    var allSemester = [
        semesterModel(semester: "1"),
        semesterModel(semester: "3"),
        semesterModel(semester: "5"),
        semesterModel(semester: "7")
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
            HStack{
                Text("Studiengangtext")
            }.padding(5)
            List{
                ForEach(0 ..< allSemester.count){ value in
                    semester(semModel: allSemester[value])
                }
            }
        }
    }
}

struct semester: View {
    @State private var tapped = false
    
    var semModel : semesterModel
    
    var body: some View{
        HStack{
            Text(self.semModel.semester)
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
