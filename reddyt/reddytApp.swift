//
//  reddytApp.swift
//  reddyt
//
//  Created by Mani on 21/11/2022.
//

import SwiftUI

@main
struct reddytApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
