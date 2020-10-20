//
//  ContentView.swift
//  StudenplanTestLocalPackageApp
//
//  Created by Eric Münch on 20.10.20.
//

import SwiftUI
import StundenplanTestLocalPackage

struct ContentView: View {
    var body: some View {
        Text(StundenplanTestLocalPackage().text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
