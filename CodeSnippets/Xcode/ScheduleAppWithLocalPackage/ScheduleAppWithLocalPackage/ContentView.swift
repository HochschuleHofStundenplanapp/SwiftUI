//
//  ContentView.swift
//  ScheduleAppWithLocalPackage
//
//  Created by Eric Münch on 20.10.20.
//

import SwiftUI
import LocalScheduleTestPackage

struct ContentView: View {
    var body: some View {
        Text(LocalScheduleTestStruct().text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
