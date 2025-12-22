//
//  BullionAppApp.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import SwiftUI

@main
struct BullionAppApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouterView()
        }
    }
}

#Preview {
    AppRouterView()
}
