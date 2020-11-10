//
//  ContentView.swift
//  Combine_Arch_Demo
//
//  Created by Peter Stöhr on 29.10.20.
//

import SwiftUI
import Combine

struct ContentView: View {
  @ObservedObject var vm = ViewModel()
  
  var body: some View {
    VStack {
      Text("\(vm.getValueFromModel())")
        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        .padding(.all)
      Button("Start", action:{vm.startTimer()})
        .padding(.all)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
      Button("Stop", action:{vm.stopTimer()})
        .padding(.all)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
