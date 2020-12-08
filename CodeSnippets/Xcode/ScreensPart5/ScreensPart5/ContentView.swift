//
//  ContentView.swift
//  ScreensPart5
//
//  Created by Xiongwei Zheng on 01.12.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var SemesterVM = SemesterViewModel()
    @State private var tapped = false
    
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
            HStack{
                Text("Studiengangtext")
            }.padding(5)
            List{
                ForEach(0 ..< SemesterVM.allSemester.count){ value in
                    semester(semModel: SemesterVM.allSemester[value])
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
