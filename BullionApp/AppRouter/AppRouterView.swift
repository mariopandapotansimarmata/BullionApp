//
//  AppRouterView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import SwiftUI

struct AppRouterView: View {
    
    @StateObject private var coordinator: AppRouter = AppRouter()
    @State private var tokenLoaded = false
    @State private var hasToken = false
    @State private var hasCompletedOnboarding = false


    private var previewPage: Page?
    
    init( previewPage: Page? = nil) {
        self.previewPage = previewPage
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: previewPage ?? .signIn)
                    .navigationDestination(for: Page.self) { page in
                        coordinator.build(page: page)
                    }
        }
        .environmentObject(coordinator)

    }
}
