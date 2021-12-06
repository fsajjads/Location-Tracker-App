//
//  assign4App.swift
//  assign4
//
//  Created by Fahim Sajjad on 11/2/21.
//

import SwiftUI

@main
struct assign4App: App {
   
  @StateObject var lm = Locationer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(lm)
             
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
