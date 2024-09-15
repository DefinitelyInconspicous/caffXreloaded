//
//  caffX_ReloadedApp.swift
//  caffX Reloaded
//
//  Created by Avyan Mehra on 7/9/24.
//

import SwiftUI

@main
struct caffX_ReloadedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(customDrink: "", entryDate: .now, selectedDrink: drink(name: "", caff: 0))
        }
    }
}
