//
//  AllSemesterView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 17.11.20.
//

import SwiftUI

struct AllSemesterView : View{
    @ObservedObject var viewModel : AllSemesterViewModel
    var body: some View{
        VStack{
            if viewModel.dataChanged{
                List {
                    ForEach(viewModel.allCourses, id: \.course) {el in
                        Section(header: Text(el.course)) {
                            ForEach(el.semester, id: \.self) { sem in
                                Text(sem).onTapGesture(perform: {
                                    viewModel.updateSemesterSelection(course: el, semester: sem)
                                })
                            }
                        }
                    }
                }
            }
            else{
                Text("Loading..")
            }
        }.onAppear{
            viewModel.loadData()
        }
    }
}

struct AllSemesterView_Previews: PreviewProvider {
    static var previews: some View {
        AllSemesterView(viewModel: AllSemesterViewModel())
    }
}
