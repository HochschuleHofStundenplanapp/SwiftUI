//
//  ContentView.swift
//  CombinePipeline
//
//  Created by Xiongwei Zheng on 20.10.20.
//

import SwiftUI

struct ContentView: View {
    
    var pipe = Pipelines()
    
    var body: some View {
        VStack {
        Text("Hello, world!")
            .padding()
        }.onAppear {
            pipe.firstPipeline()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
