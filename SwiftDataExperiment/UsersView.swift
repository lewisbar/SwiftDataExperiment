//
//  UsersView.swift
//  SwiftDataExperiment
//
//  Created by LennartWisbar on 18.10.25.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]

    var body: some View {
        List {
            ForEach(users) { user in
                HStack {
                    Text(user.name)

                    Spacer()

                    Text(String(user.unwrappedJobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
            .onDelete(perform: deleteUser)
        }
    }

    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }

    func deleteUser(_ indexSet: IndexSet) {
        for index in indexSet {
            let user = users[index]
            modelContext.delete(user)
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
