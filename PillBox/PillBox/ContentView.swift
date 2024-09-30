//
//  ContentView.swift
//  PillBox
//
//  Created by Sara Lopez Martinez on 24/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        UserTableView(userTableViewModel: UserTableViewModel())
    }
}

#Preview {
    ContentView()
}
