//
//  SwiftDataExperimentApp.swift
//  SwiftDataExperiment
//
//  Created by LennartWisbar on 17.10.25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExperimentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
