//
//  ScreensPart3App.swift
//  ScreensPart3
//
//  Created by Georg Hauschild on 10.11.20.
//

import SwiftUI

@main
struct ScreensPart3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct ScreensPart3App_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
