//
//  _May2024App.swift
//  4May2024
//
//  Created by Bryan Nguyen on 4/5/24.
//

import SwiftUI
import SwiftData

@main
struct _May2024App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
           ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
