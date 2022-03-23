//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by mac on 23/03/22.
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
