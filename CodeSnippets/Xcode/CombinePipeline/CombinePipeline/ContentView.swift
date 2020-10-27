//
//  ContentView.swift
//  CombinePipeline
//
//  Created by Xiongwei Zheng on 20.10.20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        NavigationView {
        VStack {
            NavigationLink(destination: SecondView()) {
                Text("Go")
            }.padding()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SecondView: View {
    @ObservedObject var viewModel = SecondViewModel()
        
    var body: some View {
        VStack{
            if viewModel.dataisAvailable {
                Text(viewModel.data.description)
            } else {
                Text("loading...")
            }
        }.onAppear{
            viewModel.getData()
        }
    }
    
}

class SecondViewModel: ObservableObject {
    @Published var dataisAvailable: Bool = false
    var data: [ScheduleForCourseSemester] = []
    var cancel: AnyCancellable? = nil

    func getData() {
        self.dataisAvailable = false
        data.removeAll()
        let pipe = Pipelines()
        cancel = pipe.getScheduleForCourseSemester(course: "MC", semester: 5, term: "WS").sink(receiveCompletion: {(_) in
            self.dataisAvailable = true
        }, receiveValue: { (value) in
            self.data.append(value)
        })
    }
}
