//
//  UsersView.swift
//  SwiftDataExperiment
//
//  Created by LennartWisbar on 18.10.25.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]

    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }

    init(minimumJoinDate: Date) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: \User.name)
    }
}

#Preview {
    UsersView(minimumJoinDate: .now)
        .modelContainer(for: User.self)
}
