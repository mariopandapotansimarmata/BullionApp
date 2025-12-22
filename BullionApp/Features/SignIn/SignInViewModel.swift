//
//  SignInViewModel.swift
//  BullionApp
//
//  Created by Mario Pandapotan Simarmata on 20/12/25.
//

import Combine
import Foundation

class SignInViewModel: ObservableObject {
    
    @Published var email: String = "mario@email.com"
    @Published var password: String = "97a7cc1e1e6fa238a5df6bf91cb85bb1b277b406a35191af84739d939f67acf1"
    
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
