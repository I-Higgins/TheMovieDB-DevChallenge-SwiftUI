//
//  TMDBApp.swift
//  TMDB
//
//  Created by Isaac Higgins on 24/11/23.
//

import SwiftUI

@main
struct TMDBApp: App {
    @StateObject var movieVM = MoviewViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(movieVM)
        }
    }
}
