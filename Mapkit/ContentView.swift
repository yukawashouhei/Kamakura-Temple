//
//  ContentView.swift
//  Mapkit
//
//  Created by 湯川昇平 on 2025/05/30.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = LocationsViewModel()
    
    var body: some View {
        LocationsView()
            .environmentObject(vm)
    }
}

#Preview {
    ContentView()
}
