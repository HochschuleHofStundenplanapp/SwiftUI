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
                                HStack {
                                    Text(sem)
                                    Spacer()
                                    if viewModel.isSemesterInCourseSelected(course: el, semester: sem) {
                                        Image(systemName: "checkmark")
                                    }
                                }.contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.updateSemesterSelection(course: el, semester: sem)
                                }
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
        }.navigationBarTitle(Text("Semesterwahl"), displayMode: .inline)
    }
}

struct AllSemesterView_Previews: PreviewProvider {
    static var previews: some View {
        AllSemesterView(viewModel: AllSemesterViewModel())
    }
}
