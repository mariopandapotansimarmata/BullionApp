//
//  AuthManager.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Foundation
import Combine

@MainActor
final class AuthManager: ObservableObject {

    @Published var isAuthenticated: Bool = false

    init() {
        loadToken()
    }

    func loadToken() {
        let token = UserDefaults.standard.string(forKey: "auth_token")
        isAuthenticated = !(token?.isEmpty ?? true)
    }

    func signIn(token: String) {
        UserDefaults.standard.set(token, forKey: "auth_token")
        isAuthenticated = true
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: "auth_token")
        isAuthenticated = false
    }
}
