//
//  Movie_BrowserApp.swift
//  Movie Browser
//
//  Created by Koso Suzuki on 2/3/23.
//

import SwiftUI
import Swinject

@main
struct Movie_BrowserApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .edgesIgnoringSafeArea(.all)
                .environment(\.colorScheme, .dark)
                .environmentObject(networkMonitor)
        }
    }
}
