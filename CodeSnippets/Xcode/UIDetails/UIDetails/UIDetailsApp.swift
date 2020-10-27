//
//  UIDetailsApp.swift
//  UIDetails
//
//  Created by MACBOOK on 27.10.20.
//

import SwiftUI

@main
struct UIDetailsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
