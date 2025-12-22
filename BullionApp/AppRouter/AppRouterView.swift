//
//  AppRouterView.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import SwiftUI

struct AppRouterView: View {
    
    @StateObject private var coordinator = AppRouter()
    @StateObject private var authManager = AuthManager()
    
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
        .onAppear {
            if authManager.isAuthenticated {
                coordinator.push(.home)
            }
        }
        .onChange(of: authManager.isAuthenticated) { _,_ in
            coordinator.reset()
        }
    }
}
