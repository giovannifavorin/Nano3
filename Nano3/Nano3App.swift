//
//  Nano3App.swift
//  Nano3
//
//  Created by Giovanni Favorin de Melo on 18/08/23.
//

import SwiftUI

@main
struct Nano3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
