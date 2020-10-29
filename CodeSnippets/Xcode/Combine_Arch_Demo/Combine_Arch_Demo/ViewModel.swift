//
//  ViewModel.swift
//  Combine_Arch_Demo
//
//  Created by Peter Stöhr on 29.10.20.
//

import Foundation
import Combine

class ViewModel : ObservableObject {
  @Published var vmHasChaged = false
  
  fileprivate var timer : Timer!
  fileprivate var subscription : AnyCancellable!
  
  init()
  {
    subscription = Model().modelNotifier().sink{self.vmHasChaged = true}
  }
    
  func startTimer() -> Void
  {
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in Model().update()}
  }
  
  func stopTimer() -> Void
  {
    let m = Model()

    timer.invalidate()
    m.resetData()
  }
  
  func getValueFromModel() -> String
  {
    let rawValule = Model().getValue()
    let mins = rawValule / 60
    let secs = rawValule % 60

    return String(format: "%02d", mins) + ":" + String(format: "%02d", secs)
    
  }
}
