//
//  ContentView.swift
//  SwiftDataExperiment
//
//  Created by LennartWisbar on 17.10.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var path = [User]()

    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]

    var body: some View {
        NavigationStack(path: $path) {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
                .navigationTitle("Users")
                .toolbar {
                    Button("Add User", systemImage: "plus") {
                        let newUser = User(name: "", city: "", joinDate: .now)
                        modelContext.insert(newUser)
                        path = [newUser]
                    }

                    Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])

                            Text("Sort by Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
                .navigationDestination(for: User.self) { user in
                    EditUserView(user: user)
                }
        }
    }
}

#Preview {
    ContentView()
}
