//
//  AllSemesterView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 17.11.20.
//

import SwiftUI

struct AllSemesterView : View{
    @ObservedObject var viewModel : AllSemesterViewModel
    var data = ["a", "b", "c", "d"]
    var d2 = ["1", "3", "5"]
    var body: some View{
        VStack{
            if viewModel.dataChanged{
                List {
                    ForEach(viewModel.allCourses, id: \.course) {el in
                        Section(header: Text(el.course)) {
                            ForEach(el.semester, id: \.self) { sem in
                                Text(sem)
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
