import Foundation
import Combine

class Model {
  fileprivate let sharedInstance = ModelSingleton.sharedInstance
  
  init()
  {
    //sharedInstance zur Verfügung stellen
  }

  // #####     #####     #####     #####     #####     #####     #####
  //      #####     #####     #####     #####     #####     #####
  // #####     #####     #####     #####     #####     #####     #####

  func modelNotifier() -> ObservableObjectPublisher
  {
    return sharedInstance.objectWillChange
  }

  // #####     #####     #####     #####     #####     #####     #####
  //      #####     #####     #####     #####     #####     #####
  //  MARK: Accessing the underlying model instance
  //      #####     #####     #####     #####     #####     #####
  // #####     #####     #####     #####     #####     #####     #####

  func update() -> Void
  {
    sharedInstance.value += 1
  }
  
  func getValue() -> Int
  {
    return sharedInstance.value
  }
  
  func resetData() -> Void
  {
    sharedInstance.value = 0
  }
}


fileprivate class ModelSingleton : ObservableObject {
  static let sharedInstance = ModelSingleton()
  
  @Published var modelChanged = true
  private var _value = 0
  fileprivate var value : Int {
    get {return _value}
    set (newValue){
      _value = newValue
      modelChanged = true
    }
  }
  
  private init()
  {
  }
}

