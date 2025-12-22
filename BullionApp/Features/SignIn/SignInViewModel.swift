//
//  SignInViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import Combine
import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var email: String = "admin@email.com"
    @Published var password: String = "240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9"
    
    @Published var isShowError = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    func signIn() async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        let request = LoginRequest(email: email, password: password)
        
        do {
            let response : ApiResponse<LoginResponse> = try await NetworkService.shared.post(
                "/api/v1/auth/login",
                body: request,
                responseType: ApiResponse<LoginResponse>.self
            )
            UserDefaults.standard.set(response.data.token, forKey: "auth_token")
            print(response.data)
            return true
        } catch {
            errorMessage = error.localizedDescription
            isShowError = true
            print(error)
            return false
        }
    }
}
