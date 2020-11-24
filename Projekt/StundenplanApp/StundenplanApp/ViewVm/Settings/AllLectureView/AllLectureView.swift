//
//  AllLectureView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 24.11.20.
//

import SwiftUI

struct AllLectureView : View{
    @ObservedObject var viewModel : AllLectureViewModel
    
    var body: some View{
        VStack{
            if viewModel.dataIsAvalible{
                Text(viewModel.data.description)
            }
            else{
                Text("Loading...")
            }
        }.onAppear{
            viewModel.loadData()
        }
    }
}
