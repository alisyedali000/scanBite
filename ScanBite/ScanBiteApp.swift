//
//  ScanBiteApp.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import SwiftUI
import SwiftData

@main
struct ScanBiteApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
            }.modelContainer(for: RestaurantEntity.self)
        }
    }
}
