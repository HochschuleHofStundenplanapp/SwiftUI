//
//  ContentView.swift
//  CombinePipeline
//
//  Created by Xiongwei Zheng on 20.10.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
        Text("Hello, world!")
            .padding()
        }.onAppear {
            Pipelines().output()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
