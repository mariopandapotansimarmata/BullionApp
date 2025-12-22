//
//  AppRouter.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 22/12/25.
//

import Foundation
import SwiftUI
import Observation
import Combine

enum Page: Hashable, Identifiable {
    case home
    case signIn
    case addUser
    case editUser
    
    var id: String {
        switch self {
        case .home: return "Home"
        case .signIn: return "Sign In"
        case .addUser: return "Add User"
        case .editUser: return "Edit User"
        }
    }
}

class AppRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var deleteID: String?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pushReplacement(_ page: Page) {
        path = NavigationPath()
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
        path.append(Page.home)
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
        case .home:
            HomeView()
        case .signIn:
            SignInView()
        case .addUser:
            AddUserView()
        case .editUser:
            UpdateUserView()
        }
    }
}
