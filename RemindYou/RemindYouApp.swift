//
//  RemindYouApp.swift
//  RemindYou
//
//  Created by Dylan Ngo on 11/29/22.
//

import SwiftUI

@main
struct RemindYouApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var cardsViewModel = CardsViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            TabbarView()
                .environmentObject(cardsViewModel)
        }
    }
}
